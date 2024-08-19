use axum::{
    body::Body,
    extract::Path,
    http::{header, StatusCode},
    response::{Html, IntoResponse, Response},
};
use phf::phf_map;

pub async fn root_handler() -> Html<String> {
    const INDEX_HTML_STR: &'static str = include_str!("static/index.html");
    Html(String::from(INDEX_HTML_STR))
}

pub async fn style_handler() -> impl IntoResponse {
    const STYLE_CSS_STR: &'static str = include_str!("static/style.css");
    Response::builder()
        .status(StatusCode::OK)
        .header(header::CONTENT_TYPE, "text/css")
        .body(Body::from(STYLE_CSS_STR))
        .unwrap()
}

pub async fn image_handler(Path(image_name): Path<String>) -> impl IntoResponse {
    static IMAGE_DATA_MAP: phf::Map<&'static str, &[u8]> = phf_map! {
        "container.png" => include_bytes!("images/container.png"),
        "mandatory.png" => include_bytes!("images/mandatory.png"),
        "bonus.png" => include_bytes!("images/bonus.png"),
        "structure.png" => include_bytes!("images/structure.png"),
    };
    match IMAGE_DATA_MAP.get(image_name.as_str()) {
        Some(data) => Response::builder()
            .status(StatusCode::OK)
            .header(header::CONTENT_TYPE, "image/png")
            .body(Body::from(*data))
            .unwrap(),
        None => Response::builder()
            .status(StatusCode::NOT_FOUND)
            .body(Body::from("Error: not found image"))
            .unwrap(),
    }
}
