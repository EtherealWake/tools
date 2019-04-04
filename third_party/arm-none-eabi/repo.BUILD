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
package(default_visibility = ["//visibility:public"])

licenses(["restricted"])  # GPLv3

#
# Everything
#

filegroup(
    name = "all_files",
    srcs = glob([
        "arm-none-eabi/**",
        "bin/**",
        "lib/**",
        "share/**",
    ]),
)

filegroup(
    name = "compiler_files",
    srcs = glob([
        "arm-none-eabi/bin/**",
        "bin/**",
        "lib/**",
    ]),
)

filegroup(
    name = "newlib_files",
    srcs = [
        ":newlib_includes",
        ":newlib_libraries",
    ],
)

filegroup(
    name = "newlib_includes",
    srcs = glob(["arm-none-eabi/include/**"]),
)

filegroup(
    name = "newlib_libraries",
    srcs = glob(["arm-none-eabi/lib/**"]),
)

filegroup(
    name = "sysroot",
    srcs = ["arm-none-eabi"],
)

#
# Individual Tools
#

filegroup(
    name = "ar",
    srcs = ["bin/arm-none-eabi-gcc-ar"],
)

filegroup(
    name = "as",
    srcs = ["bin/arm-none-eabi-as"],
)

filegroup(
    name = "cc",
    srcs = ["bin/arm-none-eabi-gcc"],
)

filegroup(
    name = "cov",
    srcs = ["bin/arm-none-eabi-gcov"],
)

filegroup(
    name = "cpp",
    srcs = ["bin/arm-none-eabi-cpp"],
)

filegroup(
    name = "cxx",
    srcs = ["bin/arm-none-eabi-g++"],
)

filegroup(
    name = "ld",
    srcs = ["bin/arm-none-eabi-ld"],
)

filegroup(
    name = "nm",
    srcs = ["bin/arm-none-eabi-gcc-nm"],
)

filegroup(
    name = "objcopy",
    srcs = ["bin/arm-none-eabi-objcopy"],
)

filegroup(
    name = "objdump",
    srcs = ["bin/arm-none-eabi-objdump"],
)

filegroup(
    name = "strip",
    srcs = ["bin/arm-none-eabi-strip"],
)
