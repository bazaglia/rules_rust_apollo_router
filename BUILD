load("@rules_rust//rust:defs.bzl", "rust_binary")
load("@crate_index//:defs.bzl", "all_crate_deps")

rust_binary(
    name = "router",
    srcs = glob(["src/**/*.rs"]),
    edition = "2021",
    deps = all_crate_deps(),
)
