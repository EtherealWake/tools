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

licenses(["notice"])  # Apache-2.0

#
# Everything
#

filegroup(
    name = "all_files",
    srcs = glob([
        "bin/**",
        "include/**",
        "lib/**",
    ]),
)

filegroup(
    name = "compiler_files",
    srcs = glob([
        "bin/**",
        "lib/clang/**",
    ]) + glob(
        include = ["lib/*.dll"],
        allow_empty = True,
    ) + glob(
        include = ["lib/*.dylib"],
        allow_empty = True,
    ) + glob(
        include = ["lib/*.so"],
        allow_empty = True,
    ),
)

#
# Individual Tools
#

filegroup(
    name = "ar",
    srcs = ["bin/llvm-ar"],
)

filegroup(
    name = "as",
    srcs = ["bin/llvm-as"],
)

filegroup(
    name = "cc",
    srcs = ["bin/clang"],
)

filegroup(
    name = "cl",
    srcs = ["bin/clang-cl"],
)

filegroup(
    name = "cov",
    srcs = ["bin/llvm-cov"],
)

filegroup(
    name = "cpp",
    srcs = ["bin/clang-cpp"],
)

filegroup(
    name = "cxx",
    srcs = ["bin/clang++"],
)

filegroup(
    name = "lib",
    srcs = ["bin/llvm-lib"],
)

filegroup(
    name = "link",
    srcs = ["bin/lld-link"],
)

filegroup(
    name = "ld",
    srcs = ["bin/ld.lld"],
)

filegroup(
    name = "ld64",
    srcs = ["bin/ld64.lld"],
)

filegroup(
    name = "nm",
    srcs = ["bin/llvm-nm"],
)

filegroup(
    name = "objcopy",
    srcs = ["bin/llvm-objcopy"],
)

filegroup(
    name = "objdump",
    srcs = ["bin/llvm-objdump"],
)

filegroup(
    name = "rc",
    srcs = ["bin/llvm-rc"],
)

filegroup(
    name = "strip",
    srcs = ["bin/llvm-strip"],
)
