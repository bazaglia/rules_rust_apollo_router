workspace(
    name = "rules_rust_repro",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

# Rust ruleset

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

crates_repository(
    name = "crate_index",
    annotations = {
        "v8": [crate.annotation(
            additive_build_file_content = """\
config_setting(
    name = "linux",
    constraint_values = ["@platforms//os:linux"],
)

config_setting(
    name = "macos",
    constraint_values = ["@platforms//os:macos"],
)

alias(
    name = "librusty_v8_archive",
    actual = select({
        ":macos": "@librusty_v8_release_x86_64-apple-darwin//file",
        "//conditions:default": "@librusty_v8_release_x86_64-unknown-linux-gnu//file",
    }),
)

cc_import(
    name = "librusty_v8",
    static_library = ":librusty_v8_archive",
)
""",
            gen_build_script = False,
            # build_script_data = [":librusty_v8_archive"],
            # build_script_env = {"RUSTY_V8_ARCHIVE": "$(execpath :librusty_v8_archive)"},
            deps = [":librusty_v8"],
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
    urls = ["https://github.com/denoland/rusty_v8/releases/download/v0.56.0/librusty_v8_release_x86_64-unknown-linux-gnu.a"],
)

http_file(
    name = "librusty_v8_release_x86_64-apple-darwin",
    downloaded_file_path = "librusty_v8_release_x86_64-apple-darwin.a",
    sha256 = "",
    urls = ["https://github.com/denoland/rusty_v8/releases/download/v0.56.0/librusty_v8_release_x86_64-apple-darwin.a"],
)
