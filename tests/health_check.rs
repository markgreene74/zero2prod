//! tests/health_check.rs

use zero2prod::run;

#[actix_web::test]
async fn health_check_works() {
    // start the application
    spawn_app();

    // use reqwest to perform HTTP requests against the application
    let client = reqwest::Client::new();
    let response = client
        .get("http://127.0.0.1:8080/health_check")
        .send()
        .await
        .expect("Failed to execute request.");

    // asserts go here
    assert!(response.status().is_success());
    assert_eq!(Some(2), response.content_length());
}

fn spawn_app() {
    let server = run("127.0.0.1:8080").expect("Failed to bind address");
    let _ = actix_web::rt::spawn(server);
}
