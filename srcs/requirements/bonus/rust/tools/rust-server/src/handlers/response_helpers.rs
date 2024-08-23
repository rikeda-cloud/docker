use axum::{
    body::Body,
    http::{header, StatusCode},
    response::Response,
};

pub fn generate_not_found_response(error_message: &'static str) -> Response<Body> {
    Response::builder()
        .status(StatusCode::NOT_FOUND)
        .body(Body::from(error_message))
        .unwrap()
}

pub fn generate_text_response(content_type: &'static str, body: &'static str) -> Response<Body> {
    Response::builder()
        .status(StatusCode::OK)
        .header(header::CONTENT_TYPE, content_type)
        .body(Body::from(body))
        .unwrap()
}

pub fn generate_binary_response(content_type: &'static str, body: &'static [u8]) -> Response<Body> {
    Response::builder()
        .status(StatusCode::OK)
        .header(header::CONTENT_TYPE, content_type)
        .body(Body::from(body))
        .unwrap()
}
