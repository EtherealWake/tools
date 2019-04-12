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
"""C/C++ Language Support."""

load("//cc:toolchain.bzl", "clang_toolchain")

package(default_visibility = ["//visibility:public"])

#
# Common Constants
#

UNIX_COPTS = [
    # Security Enhancements
    "-U_FORTIFY_SOURCE",
    "-D_FORTIFY_SOURCE=1",
    "-fstack-protector",
    # Diagnostics
    "-Wall",
    "-Wextra",
    "-Werror",
    "-fcolor-diagnostics",
]

UNIX_FEATURES = [
    "supports_dynamic_linker",
    "supports_pic",
    "supports_start_end_lib",
]

UNIX_LINKOPTS = [
    # Linking Options
    "-fuse-ld=lld",
    # Security Enhancements
    "-Wl,-z,relro,-z,now",
]

UNIX_MODES = {
    # Optimize for Debugging Experience
    "dbg.copts": [
        "-Og",
        "-ggdb",
        "-gz",
    ],
    "dbg.linkopts": ["-Wl,--compress-debug-sections=zlib"],
    # Optimize for Build Speed
    "fastbuild.copts": [
        "-O1",
        "-g0",
    ],
    # Optimize for Run-Time Performance
    "opt.copts": [
        "-DNDEBUG",
        "-O2",
        "-fdata-sections",
        "-ffunction-sections",
        "-flto",
        "-gmlt",
    ],
    "opt.linkopts": ["-Wl,--gc-sections,-O2"],
}

filegroup(name = "empty")

#
# Legacy Configuration
#

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "freebsd": ":x86_64-freebsd-native-toolchain",
        "k8": ":x86_64-linux-native-toolchain",
    },
)

#
# FreeBSD
#

# Native Build
clang_toolchain(
    name = "x86_64-freebsd-native",
    builtin_include_directories = [
        "/usr/include",
        "/usr/lib/clang",
        "/usr/local/include",
    ],
    copts = UNIX_COPTS,
    exec_compatible_with = [
        "//constraints/cpu:x86_64",
        "//constraints/os:freebsd",
    ],
    features = UNIX_FEATURES,
    linkopts = UNIX_LINKOPTS,
    modes = UNIX_MODES,
    target = "x86_64-unknown-freebsd12.0",
    target_compatible_with = [
        "//constraints/cpu:x86_64",
        "//constraints/os:freebsd",
    ],
)

#
# Linux
#

# Native Build
clang_toolchain(
    name = "x86_64-linux-native",
    builtin_include_directories = [
        "/usr/include",
        "/usr/lib/gcc",
        "/usr/local/include",
    ],
    copts = UNIX_COPTS,
    exec_compatible_with = [
        "//constraints/cpu:x86_64",
        "//constraints/os:linux",
    ],
    features = UNIX_FEATURES,
    linkopts = UNIX_LINKOPTS,
    modes = UNIX_MODES,
    target = "x86_64-unknown-linux-gnu",
    target_compatible_with = [
        "//constraints/cpu:x86_64",
        "//constraints/os:linux",
    ],
)

#
# Tests
#

cc_test(
    name = "test",
    size = "small",
    srcs = ["test.cpp"],
    deps = [":testlib"],
)

cc_library(
    name = "testlib",
    srcs = ["testlib.cpp"],
    hdrs = ["testlib.hpp"],
)
