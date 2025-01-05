//! tests/health_check.rs

use std::net::TcpListener;
use zero2prod::run;

#[actix_web::test]
async fn health_check_works() {
    // start the application
    let address = spawn_app();
    // dbg!(&address); // DEBUG

    // use reqwest to perform HTTP requests against the application
    let client = reqwest::Client::new();
    let response = client
        .get(&format!("{}/health_check", &address))
        .send()
        .await
        .expect("Failed to execute request.");

    // asserts go here
    // dbg!(&response); // DEBUG
    assert!(response.status().is_success());
    assert_eq!(Some(2), response.content_length());
}

fn spawn_app() -> String {
    let listener = TcpListener::bind("127.0.0.1:0").expect("Failed to bind random port");
    let port = listener.local_addr().unwrap().port();
    let server = run(listener).expect("Failed to bind address");
    let _ = actix_web::rt::spawn(server);
    format!("http://127.0.0.1:{}", port)
}
