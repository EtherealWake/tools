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

load("//cc:toolchain.bzl", "arm_toolchain", "clang_toolchain")

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
        "k8|clang": ":x86_64-linux-native-toolchain",
        "k8|compiler": ":x86_64-linux-native-toolchain",
    },
)

cc_toolchain_suite(
    name = "toolchain-cross",
    toolchains = {
        "aarch64": ":aarch64-linux-toolchain",
        "arm": ":arm-linux-toolchain",
        "cortex-m4f": ":cortex-m4f-toolchain",
        "k8": ":x86_64-linux-toolchain",
        "piii": ":i386-linux-toolchain",
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

clang_toolchain(
    name = "arm-linux",
    copts = [
        "--target=armv7a-unknown-linux-gnueabihf",
    ] + UNIX_COPTS,
    cpu = "armv7-linux",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=armv7a-unknown-linux-gnueabihf",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@org_chromium_sysroot_linux_arm//:sysroot",
    target = "armv7a-unknown-linux-gnueabihf",
    target_compatible_with = [
        "//constraints/cpu:arm",
        "//constraints/os:linux",
    ],
    target_files = ["@org_chromium_sysroot_linux_arm//:all_files"],
)

clang_toolchain(
    name = "aarch64-linux",
    copts = [
        "--target=aarch64-unknown-linux-gnu",
    ] + UNIX_COPTS,
    cpu = "aarch64-linux",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=aarch64-unknown-linux-gnu",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@org_chromium_sysroot_linux_arm64//:sysroot",
    target = "aarch64-unknown-linux-gnu",
    target_compatible_with = [
        "//constraints/cpu:aarch64",
        "//constraints/os:linux",
    ],
    target_files = ["@org_chromium_sysroot_linux_arm64//:all_files"],
)

clang_toolchain(
    name = "i386-linux",
    copts = [
        "--target=i386-unknown-linux-gnu",
    ] + UNIX_COPTS,
    cpu = "i386-linux",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=i386-unknown-linux-gnu",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@org_chromium_sysroot_linux_i386//:sysroot",
    target = "i386-unknown-linux-gnu",
    target_compatible_with = [
        "//constraints/cpu:i386",
        "//constraints/os:linux",
    ],
    target_files = ["@org_chromium_sysroot_linux_i386//:all_files"],
)

clang_toolchain(
    name = "x86_64-linux",
    copts = [
        "--target=x86_64-unknown-linux-gnu",
    ] + UNIX_COPTS,
    cpu = "x86_64-linux",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=x86_64-unknown-linux-gnu",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@org_chromium_sysroot_linux_amd64//:sysroot",
    target = "x86_64-unknown-linux-gnu",
    target_compatible_with = [
        "//constraints/cpu:x86_64",
        "//constraints/os:linux",
    ],
    target_files = ["@org_chromium_sysroot_linux_amd64//:all_files"],
)

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
# ARM Embedded
#

arm_toolchain(
    name = "cortex-m4f",
    copts = [
        "-fdiagnostics-color",
        # Targetting
        "-mcpu=cortex-m4",
        "-mfloat-abi=hard",
        "--specs=nosys.specs",
        # Diagnostics
        "-Wall",
        "-Wextra",
        "-Werror",
        # Optimization
        "-Os",
        "-flto",
    ],
    cpu = "cortex-m4f",
    linkopts = [
        "-fdiagnostics-color",
        # Targetting
        "-mcpu=cortex-m4",
        "-mfloat-abi=hard",
        "-nostartfiles",
        "-Wl,--nmagic",
        "--specs=nosys.specs",
        # Diagnostics
        "-Wall",
        "-Wextra",
        "-Werror",
    ],
    modes = {
        "dbg.copts": [
            "-gz",
            "-ggdb",
        ],
        "fastbuild.copts": ["-g0"],
        "opt.copts": [
            "-gz",
            "-ggdb",
        ],
    },
    target = "armv7em-none-eabihf",
    target_compatible_with = [
        "//constraints/core/arm:cortex-m4",
        "//constraints/cpu:arm",
        "//constraints/endian:little",
        "//constraints/float:hard",
        "//constraints/os:none",
    ],
)

#
# Tests
#

# Validation of Embedded Build
cc_binary(
    name = "start",
    srcs = ["start.cpp"],
    tags = ["manual"],
)

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
