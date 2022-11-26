workspace(
    name = "rules_rust_repro",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

# Protobuf rules

http_archive(
    name = "rules_proto",
    sha256 = "80d3a4ec17354cccc898bfe32118edd934f851b03029d63ef3fc7c8663a7415c",
    strip_prefix = "rules_proto-5.3.0-21.5",
    urls = [
        "https://github.com/bazelbuild/rules_proto/archive/refs/tags/5.3.0-21.5.tar.gz",
    ],
)

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()

# Rust rules

http_archive(
    name = "rules_rust",
    sha256 = "da67916d7e416b7dd3d8725c672caeeaf9fad8ffda963dc84e77a2120e3475b5",
    strip_prefix = "rules_rust-fix-common-glob-exclude",
    urls = ["https://github.com/bazaglia/rules_rust/archive/refs/heads/fix/common-glob-exclude.zip"],
)

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")

rules_rust_dependencies()

rust_register_toolchains()

load("@rules_rust//crate_universe:repositories.bzl", "crate_universe_dependencies")

crate_universe_dependencies(bootstrap = True)

load("@rules_rust//crate_universe:defs.bzl", "crate", "crates_repository")
load("//:rust_annotations.bzl", "V8_ADDITIVE_BUILD_FILE_CONTENT")

crates_repository(
    name = "crate_index",
    annotations = {
        "v8": [crate.annotation(
            additive_build_file_content = V8_ADDITIVE_BUILD_FILE_CONTENT,
            gen_build_script = False,
            deps = [":librusty_v8"],
        )],
        "apollo-router": [crate.annotation(
            build_script_data = [
                "@com_google_protobuf//:protoc",
                "@com_google_protobuf//:well_known_type_protos",
            ],
            build_script_env = {
                "PROTOC": "$(execpath @com_google_protobuf//:protoc)",
                # Add protos from @com_google_protobuf//:well_known_type_protos
                # I couldn't use the predefined variables since it expands to
                # more than one file. There should be a better approach still.
                # https://bazel.build/reference/be/make-variables#predefined_label_variables
                "PROTOC_INCLUDE": "$${pwd}/external/com_github_protocolbuffers_protobuf/src",
            },
        )],
        "opentelemetry-proto": [crate.annotation(
            build_script_data = ["@com_google_protobuf//:protoc"],
            build_script_env = {"PROTOC": "$(execpath @com_google_protobuf//:protoc)"},
        )],
    },
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

http_file(
    name = "librusty_v8_release_x86_64-unknown-linux-gnu",
    downloaded_file_path = "librusty_v8_release_x86_64-unknown-linux-gnu.a",
    sha256 = "",
    urls = ["https://github.com/denoland/rusty_v8/releases/download/v0.44.3/librusty_v8_release_x86_64-unknown-linux-gnu.a"],
)

http_file(
    name = "librusty_v8_release_x86_64-apple-darwin",
    downloaded_file_path = "librusty_v8_release_x86_64-apple-darwin.a",
    sha256 = "7f4941adac98368ee2bc2a9e25c605e443049e6ae01fea872e87cccdb509f8eb",
    urls = ["https://github.com/denoland/rusty_v8/releases/download/v0.44.3/librusty_v8_release_x86_64-apple-darwin.a"],
)
