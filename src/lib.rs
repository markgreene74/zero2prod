//! lib.rs

use actix_web::dev::Server;
use actix_web::http::StatusCode;
use actix_web::{get, post, web, App, HttpServer, Responder};
use std::net::TcpListener;

#[derive(serde::Deserialize)]
struct FormData {
    name: String,
    media: String,
}

#[get("/health_check")]
async fn health_check() -> impl Responder {
    "OK"
}

#[post("/query")]
async fn query(form: web::Form<FormData>) -> impl Responder {
    let response = format!("name: {}, media: {}", form.name, form.media)
        .customize()
        .with_status(StatusCode::OK);
    response
}

pub fn run(listener: TcpListener) -> std::io::Result<Server> {
    let server = HttpServer::new(|| App::new().service(health_check).service(query))
        .listen(listener)?
        .run();
    Ok(server)
}
