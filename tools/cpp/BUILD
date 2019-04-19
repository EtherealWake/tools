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

load("//cc:rules.bzl", "cc_library", "cc_test")
load("//cc:toolchain.bzl", "arm_toolchain", "clang_toolchain")
load("//embedded:rules.bzl", "embedded_binary")

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
# FreeBSD
#

clang_toolchain(
    name = "aarch64-unknown-freebsd",
    copts = [
        "--target=aarch64-unknown-freebsd12.0",
    ] + UNIX_COPTS,
    cpu = "aarch64",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=aarch64-unknown-freebsd12.0",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@com_etherealwake_sysroot_freebsd_arm64//:sysroot",
    target = "aarch64-unknown-freebsd12.0",
    target_compatible_with = [
        "//constraints/cpu:aarch64",
        "//constraints/os:freebsd",
    ],
    target_files = ["@com_etherealwake_sysroot_freebsd_arm64//:all_files"],
)

clang_toolchain(
    name = "armv7-gnueabihf-freebsd",
    copts = [
        "--target=armv7-gnueabihf-freebsd12.0",
    ] + UNIX_COPTS,
    cpu = "armv7",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=armv7-gnueabihf-freebsd12.0",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@com_etherealwake_sysroot_freebsd_armv7//:sysroot",
    target = "armv7a-gnueabihf-freebsd12.0",
    target_compatible_with = [
        "//constraints/arch/arm:armv7-a",
        "//constraints/cpu:arm",
        "//constraints/os:freebsd",
    ],
    target_files = ["@com_etherealwake_sysroot_freebsd_armv7//:all_files"],
)

clang_toolchain(
    name = "i386-unknown-freebsd",
    copts = [
        "--target=i386-unknown-freebsd12.0",
    ] + UNIX_COPTS,
    cpu = "x86_32",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=i386-unknown-freebsd12.0",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@com_etherealwake_sysroot_freebsd_i386//:sysroot",
    target = "i386-unknown-freebsd12.0",
    target_compatible_with = [
        "//constraints/cpu:x86_32",
        "//constraints/os:freebsd",
    ],
    target_files = ["@com_etherealwake_sysroot_freebsd_i386//:all_files"],
)

clang_toolchain(
    name = "x86_64-unknown-freebsd",
    copts = [
        "--target=x86_64-unknown-freebsd12.0",
    ] + UNIX_COPTS,
    cpu = "x86_64",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=x86_64-unknown-freebsd12.0",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@com_etherealwake_sysroot_freebsd_amd64//:sysroot",
    target = "x86_64-unknown-freebsd12.0",
    target_compatible_with = [
        "//constraints/cpu:x86_64",
        "//constraints/os:freebsd",
    ],
    target_files = ["@com_etherealwake_sysroot_freebsd_amd64//:all_files"],
)

# Native Build
clang_toolchain(
    name = "x86_64-unknown-freebsd-native",
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
    name = "armv7a-unknown-linux-gnueabihf",
    copts = [
        "--target=armv7a-unknown-linux-gnueabihf",
    ] + UNIX_COPTS,
    cpu = "armv7",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=armv7a-unknown-linux-gnueabihf",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@org_chromium_sysroot_linux_arm//:sysroot",
    target = "armv7a-unknown-linux-gnueabihf",
    target_compatible_with = [
        "//constraints/arch/arm:armv7-a",
        "//constraints/cpu:arm",
        "//constraints/os:linux",
    ],
    target_files = ["@org_chromium_sysroot_linux_arm//:all_files"],
)

clang_toolchain(
    name = "aarch64-unknown-linux-gnu",
    copts = [
        "--target=aarch64-unknown-linux-gnu",
    ] + UNIX_COPTS,
    cpu = "aarch64",
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
    name = "i686-pc-linux-gnu",
    copts = [
        "--target=i686-pc-linux-gnu",
    ] + UNIX_COPTS,
    cpu = "x86_32",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=i686-pc-linux-gnu",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@org_chromium_sysroot_linux_i386//:sysroot",
    target = "i686-pc-linux-gnu",
    target_compatible_with = [
        "//constraints/cpu:x86_32",
        "//constraints/os:linux",
    ],
    target_files = ["@org_chromium_sysroot_linux_i386//:all_files"],
)

clang_toolchain(
    name = "x86_64-pc-linux-gnu",
    copts = [
        "--target=x86_64-pc-linux-gnu",
    ] + UNIX_COPTS,
    cpu = "x86_64",
    features = UNIX_FEATURES,
    linkopts = [
        "--target=x86_64-pc-linux-gnu",
    ] + UNIX_LINKOPTS,
    modes = UNIX_MODES,
    sysroot = "@org_chromium_sysroot_linux_amd64//:sysroot",
    target = "x86_64-pc-linux-gnu",
    target_compatible_with = [
        "//constraints/cpu:x86_64",
        "//constraints/os:linux",
    ],
    target_files = ["@org_chromium_sysroot_linux_amd64//:all_files"],
)

# Native Build
clang_toolchain(
    name = "x86_64-pc-linux-gnu-native",
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
    target = "x86_64-pc-linux-gnu",
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

embedded_binary(
    name = "embedded",
    srcs = ["start.cpp"],
    platform = "//platforms/arm:cortex-m4f",
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
