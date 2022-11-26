V8_ADDITIVE_BUILD_FILE_CONTENT = """\
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
"""
