# rules_rust_apollo_router

This project integrates [Apollo Router](https://github.com/apollographql/router/) with Bazel, creating a [custom binary of the Apollo Router](https://www.apollographql.com/docs/router/customizations/custom-binary#1-create-a-new-project) so it can be customized using plugins.

To build the Apollo Router binary with Bazel:

```
bazel build //:router
```

A few annotations have to be added to the `crates_repository` rule to get the compilation working with Bazel using the Rust rules. They can be found in the `WORKSPACE` file.

### Compile the router without Bazel

To create a debug build use the following command.

```bash
cargo build
```

Your debug binary is now located in `target/debug/router`

### Run the Apollo Router

```bash
cargo run -- --hot-reload --config router.yaml --supergraph supergraph-schema.graphql
```
