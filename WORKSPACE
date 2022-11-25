workspace(
    name = "rules_rust_repro",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

# Rust ruleset

http_archive(
    name = "rules_rust",
    strip_prefix = "rules_rust-fix-crate-exclude-glob-spaces",
    urls = ["https://github.com/bazaglia/rules_rust/archive/refs/heads/fix/crate-exclude-glob-spaces.zip"],
)

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")

rules_rust_dependencies()

rust_register_toolchains()

load("@rules_rust//crate_universe:repositories.bzl", "crate_universe_dependencies")

crate_universe_dependencies(bootstrap = True)

load("@rules_rust//crate_universe:defs.bzl", "crates_repository")

crates_repository(
    name = "crate_index",
    cargo_lockfile = "//:Cargo.lock",
    generator = "@cargo_bazel_bootstrap//:cargo-bazel",
    lockfile = "//:cargo-bazel-lock.json",
    manifests = [
        "//:Cargo.toml",
        "//:xtask/Cargo.toml",
    ],
)

load("@crate_index//:defs.bzl", "crate_repositories")

crate_repositories()

# Useful binaries

# Had to provide `rustfmt` to one of the build targets when using cargo-raze.
http_archive(
    name = "rustfmt",
    build_file_content = """exports_files(["rustfmt"])""",
    sha256 = "177386d87098114d74af0994a868dcc3f975bab066c38e5712f5f30573631e64",
    strip_prefix = "rustfmt_macos-x86_64_v1.5.1",
    url = "https://github.com/rust-lang/rustfmt/releases/download/v1.5.1/rustfmt_macos-x86_64_v1.5.1.tar.gz",
)

# Tried to create a cc_import providing file. It didn't work.
http_file(
    name = "librusty_v8",
    downloaded_file_path = "librusty_v8.a",
    sha256 = "7f4941adac98368ee2bc2a9e25c605e443049e6ae01fea872e87cccdb509f8eb",
    url = "https://github.com/denoland/rusty_v8/releases/download/v0.44.3/librusty_v8_release_x86_64-apple-darwin.a",
)
