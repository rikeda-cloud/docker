use axum::{extract::Path, response::IntoResponse};
use phf::phf_map;
mod response_helpers;
use response_helpers::{
    generate_binary_response, generate_not_found_response, generate_text_response,
};

pub async fn root_handler() -> impl IntoResponse {
    html_handler(Path("".to_string())).await
}

pub async fn html_handler(Path(html_name): Path<String>) -> impl IntoResponse {
    static HTML_DATA_MAP: phf::Map<&'static str, &'static str> = phf_map! {
        "" => include_str!("static/index.html"),
        "index.html" => include_str!("static/index.html"),
        "container.html" => include_str!("static/container.html"),
        "mandatory.html" => include_str!("static/mandatory.html"),
        "bonus.html" => include_str!("static/bonus.html"),
        "structure.html" => include_str!("static/structure.html"),
    };
    match HTML_DATA_MAP.get(html_name.as_str()) {
        Some(data) => generate_text_response("text/html", data),
        None => generate_not_found_response("Error: not found html"),
    }
}

pub async fn style_handler(Path(css_name): Path<String>) -> impl IntoResponse {
    static CSS_DATA_MAP: phf::Map<&'static str, &'static str> = phf_map! {
        "style.css" => include_str!("static/style.css"),
        "docker_details.css" => include_str!("static/docker_details.css"),
    };
    match CSS_DATA_MAP.get(css_name.as_str()) {
        Some(data) => generate_text_response("text/css", data),
        None => generate_not_found_response("Error: not found css"),
    }
}

pub async fn image_handler(Path(image_name): Path<String>) -> impl IntoResponse {
    static IMAGE_DATA_MAP: phf::Map<&'static str, &[u8]> = phf_map! {
        "container.png" => include_bytes!("images/container.png"),
        "mandatory.png" => include_bytes!("images/mandatory.png"),
        "bonus.png" => include_bytes!("images/bonus.png"),
        "structure.png" => include_bytes!("images/structure.png"),
    };
    match IMAGE_DATA_MAP.get(image_name.as_str()) {
        Some(data) => generate_binary_response("image/png", data),
        None => generate_not_found_response("Error: not found image"),
    }
}
