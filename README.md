# zero2prod
My repository for '[Zero To Production In Rust](https://www.zero2prod.com/)'.

## Things that I am doing differently from the book

### Don't use Tokio

No particular reason. I just wanted to see if I could get away with one less dependency (`tokio`), and so far (Chapter 3) looks like it's possible.

### Change the main functionality of the application

Again, no particular reason apart from personal preference and trying to introduce some changes (i.e., do not copy&paste the book).

Instead of creating an application to manage newsletter subscriptions we are building a basic implementation of [`whistab`](https://github.com/markgreene74/whistab). Given the name of character in a film, I want to know where else I might have seen the actor (i.e., which other films or TV series).

There are however other problems with this approach which might make it not suitable for now.

## Loading the data in Postgres

The data is very clean, however there is a problem to `COPY` it directly into a table in Postgres when titles contain the double quote character (`"`).

The simplest solution seems to be to pre-process the `tsv` files and replace the double quote characters (`"`) with single quotes (`'`).

## References and useful links

- [GitHub - Zero To Production In Rust](https://github.com/LukeMathWalker/zero-to-production) Code for "Zero To Production In Rust".
- [GitHub - Actix Web](https://github.com/actix/actix-web)
- [GitHub - Actix Web Examples](https://github.com/actix/examples)
- [GitHub - Serde](https://github.com/serde-rs/serde)
- [IMDb Non-Commercial Datasets](https://datasets.imdbws.com/)
