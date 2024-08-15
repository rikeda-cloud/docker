use axum::{
    body::Body,
    extract::Path,
    http::{header, StatusCode},
    response::{Html, IntoResponse, Response},
    routing::get,
    Router,
};

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(root_handler))
        .route("/index.html", get(root_handler))
        .route("/static/style.css", get(style_handler))
        .route("/images/:image_name", get(image_handler));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:4000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn root_handler() -> Result<Html<String>, (StatusCode, String)> {
    match tokio::fs::read_to_string("/var/www/html/index.html").await {
        Ok(html_data) => Ok(Html(html_data)),
        Err(_) => Err((
            StatusCode::INTERNAL_SERVER_ERROR,
            "Error: read index.html".into(),
        )),
    }
}

async fn style_handler() -> impl IntoResponse {
    match tokio::fs::read_to_string("/var/www/html/style.css").await {
        Ok(style_data) => Response::builder()
            .status(StatusCode::OK)
            .header(header::CONTENT_TYPE, "text/css")
            .body(Body::from(style_data))
            .unwrap(),
        Err(_) => Response::builder()
            .status(StatusCode::NOT_FOUND)
            .body(Body::from("Error: not found style"))
            .unwrap(),
    }
}

async fn image_handler(Path(image_name): Path<String>) -> impl IntoResponse {
    let image_file_path = format!("/var/www/html/{}", image_name);
    match tokio::fs::read(image_file_path).await {
        Ok(image_data) => Response::builder()
            .status(StatusCode::OK)
            .header(header::CONTENT_TYPE, "image/png")
            .body(Body::from(image_data))
            .unwrap(),
        Err(_) => Response::builder()
            .status(StatusCode::NOT_FOUND)
            .body(Body::from("Error: not found image"))
            .unwrap(),
    }
}
