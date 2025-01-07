//! main.rs

use std::net::TcpListener;
use zero2prod::run;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let listener = TcpListener::bind("0.0.0.0:8080").expect("Failed to bind port 8080");
    run(listener)?.await
}
