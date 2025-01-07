FROM rust:1.83-slim-bookworm as builder
WORKDIR /usr/src/zero2prod-app
COPY . .
RUN cargo install --path .

FROM debian:bookworm-slim
#RUN apt-get update && apt-get install -y extra-runtime-dependencies && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/zero2prod /usr/local/bin/zero2prod
EXPOSE 8080
CMD ["zero2prod"]
