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
"""Embedded C/C++ Support."""

load("//cc:toolchain.bzl", "arm_toolchain")
load("//embedded:rules.bzl", "embedded_binary")

package(default_visibility = ["//visibility:public"])

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
