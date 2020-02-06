FROM rustlang/rust:nightly-slim AS build
RUN apt-get update; apt-get install -y musl-tools
RUN rustup update
RUN rustup target install x86_64-unknown-linux-musl
COPY . /app/
WORKDIR /app
RUN cargo build --release --target=x86_64-unknown-linux-musl

FROM scratch AS deploy
COPY --from=build /app/target/x86_64-unknown-linux-musl/release/actix-app-template /
EXPOSE 8000
ENTRYPOINT ["/actix-app-template"]