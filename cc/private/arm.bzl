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
"""Implementation of GCC C/C++ Toolchain for Embedded ARM Applications."""

load(":gcc.bzl", "gcc_cc_toolchain_config", "gcc_toolchain")

DEFAULT_ALLFILES = "@com_etherealwake_tools//third_party/arm-none-eabi:all_files"
DEFAULT_CCFILES = "@com_etherealwake_tools//third_party/arm-none-eabi:compiler_files"
DEFAULT_ARCHIVER = "@com_etherealwake_tools//third_party/arm-none-eabi:ar"
DEFAULT_COMPILER = "@com_etherealwake_tools//third_party/arm-none-eabi:cc"
DEFAULT_LINKER = "@com_etherealwake_tools//third_party/arm-none-eabi:cxx"
DEFAULT_OBJCOPY = "@com_etherealwake_tools//third_party/arm-none-eabi:objcopy"
DEFAULT_STRIP = "@com_etherealwake_tools//third_party/arm-none-eabi:strip"

def arm_cc_toolchain_config(
        name,
        artool = DEFAULT_ARCHIVER,
        cctool = DEFAULT_COMPILER,
        linktool = DEFAULT_LINKER,
        objcopy = DEFAULT_OBJCOPY,
        strip = DEFAULT_STRIP,
        **kwargs):
    return gcc_cc_toolchain_config(
        name = name,
        artool = artool,
        cctool = cctool,
        linktool = linktool,
        objcopy = objcopy,
        strip = strip,
        **kwargs
    )

def arm_toolchain(
        name,
        all_files = DEFAULT_ALLFILES,
        artool = DEFAULT_ARCHIVER,
        cctool = DEFAULT_COMPILER,
        compiler_files = DEFAULT_CCFILES,
        linktool = DEFAULT_LINKER,
        objcopy = DEFAULT_OBJCOPY,
        strip = DEFAULT_STRIP,
        **kwargs):
    return gcc_toolchain(
        name = name,
        all_files = all_files,
        artool = artool,
        cctool = cctool,
        compiler_files = compiler_files,
        linktool = linktool,
        objcopy = objcopy,
        strip = strip,
        **kwargs
    )
