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

#[actix_web::test]
async fn query_returns_200_for_valid_data() {
    // start the application
    let address = spawn_app();

    // send the request
    let client = reqwest::Client::new();
    let body = "name=joe%20miller&media=the%20expanse";
    let response = client
        .post(&format!("{}/query", &address))
        .header("Content-Type", "application/x-www-form-urlencoded")
        .body(body)
        .send()
        .await
        .expect("Failed to execute request.");

    // asserts
    assert_eq!(200, response.status().as_u16());
}

#[actix_web::test]
async fn query_returns_400_for_invalid_data() {
    // start the application
    let address = spawn_app();

    // send the requests
    let client = reqwest::Client::new();
    let test_cases = vec![
        ("name=joe%20miller", "missing the media (film or show)"),
        ("media=the%20expanse", "missing the character name"),
        ("", "missing both character name and media (film or show)"),
    ];

    for (invalid_body, error_message) in test_cases {
        let response = client
            .post(&format!("{}/query", &address))
            .header("Content-Type", "application/x-www-form-urlencoded")
            .body(invalid_body)
            .send()
            .await
            .expect("Failed to execute request.");

        // asserts
        assert_eq!(
            400,
            response.status().as_u16(),
            "The API did not fail with 400 Bad Request when the payload was {}.",
            error_message
        );
    }
}

#[cfg(not(target_os = "macos"))]
#[test]
fn dummy_db_test() {
    // this should be executed only when running in docker
    // or never executed when running locally on macOS
}

// helpers

fn spawn_app() -> String {
    let listener = TcpListener::bind("127.0.0.1:0").expect("Failed to bind random port");
    let port = listener.local_addr().unwrap().port();
    let server = run(listener).expect("Failed to start server");
    let _ = actix_web::rt::spawn(server);
    format!("http://127.0.0.1:{}", port)
}
