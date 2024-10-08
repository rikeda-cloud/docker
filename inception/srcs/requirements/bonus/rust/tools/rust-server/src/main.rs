mod handlers;
use axum::{routing::get, Router};

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(handlers::root_handler))
        .route("/:html_name", get(handlers::html_handler))
        .route("/static/:css_name", get(handlers::style_handler))
        .route("/images/:image_name", get(handlers::image_handler));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:4000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
