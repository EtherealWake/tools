#
# Copyright (c) 2019 Jonathan McGee <broken.source@etherealwake.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
"""Dependency handling for @com_etherealwake_tools."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//third_party/arm-none-eabi:repo.bzl", "arm_dependencies")
load("//third_party/chrome-linux-sysroot:repo.bzl", "linux_dependencies")
load("//third_party/clang+llvm:repo.bzl", "llvm_dependencies")
load("//third_party/freebsd-sysroot:repo.bzl", "freebsd_dependencies")

def _maybe(name, rule, **kwargs):
    if name not in native.existing_rules():
        rule(name = name, **kwargs)

def tools_dependencies():
    _maybe(
        name = "platforms",
        rule = http_archive,
        sha256 = "f148e251136c57f14226652194518a2babd53e5660063c84c75f78167408d27c",
        strip_prefix = "platforms-43155b81d40765f0d13008bc77cd2cca8ba9fb2a",
        url = "https://github.com/bazelbuild/platforms/archive/43155b81d40765f0d13008bc77cd2cca8ba9fb2a.zip",
    )
    _maybe(
        name = "rules_cc",
        rule = http_archive,
        sha256 = "b4b2a2078bdb7b8328d843e8de07d7c13c80e6c89e86a09d6c4b424cfd1aaa19",
        strip_prefix = "rules_cc-cb2dfba6746bfa3c3705185981f3109f0ae1b893",
        url = "https://github.com/bazelbuild/rules_cc/archive/cb2dfba6746bfa3c3705185981f3109f0ae1b893.zip",
    )
    arm_dependencies()
    llvm_dependencies()
    freebsd_dependencies()
    linux_dependencies()

def tools_register_cross_toolchains():
    """Register C/C++ Toolchains for Cross-Compiling."""
    native.register_toolchains(
        # FreeBSD Targets
        "@com_etherealwake_tools//tools/cpp:aarch64-unknown-freebsd",
        "@com_etherealwake_tools//tools/cpp:armv7-gnueabihf-freebsd",
        "@com_etherealwake_tools//tools/cpp:i386-unknown-freebsd",
        "@com_etherealwake_tools//tools/cpp:x86_64-unknown-freebsd",
        # Linux Targets
        "@com_etherealwake_tools//tools/cpp:aarch64-unknown-linux-gnu",
        "@com_etherealwake_tools//tools/cpp:armv7a-unknown-linux-gnueabihf",
        "@com_etherealwake_tools//tools/cpp:i686-pc-linux-gnu",
        "@com_etherealwake_tools//tools/cpp:x86_64-pc-linux-gnu",
    )

def tools_register_native_toolchains():
    """Register C/C++ Toolchains for Native Builds."""
    native.register_toolchains(
        "@com_etherealwake_tools//tools/cpp:x86_64-unknown-freebsd-native",
        "@com_etherealwake_tools//tools/cpp:x86_64-pc-linux-gnu-native",
    )
