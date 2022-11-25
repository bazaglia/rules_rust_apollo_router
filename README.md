# rust_rust_repro

It just creates a [custom binary of the Apollo Router](https://www.apollographql.com/docs/router/customizations/custom-binary#1-create-a-new-project) so it can be customized using plugins.

When trying to build using Bazel:

```
bazel build //:router
```

It fails with the following error:

```
error: could not find native static library `rusty_v8`, perhaps an -L flag is missing?
```

### Compile the router

To create a debug build use the following command.

```bash
cargo build
```

Your debug binary is now located in `target/debug/router`

### Run the Apollo Router

```bash
cargo run -- --hot-reload --config router.yaml --supergraph supergraph-schema.graphql
```
