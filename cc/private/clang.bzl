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
"""Implementation of Clang C/C++ Toolchain for Unix Systems."""

load(":gcc.bzl", "gcc_cc_toolchain_config", "gcc_toolchain")

DEFAULT_ALLFILES = "@com_etherealwake_tools//third_party/clang+llvm:compiler_files"
DEFAULT_ARTOOL = "@com_etherealwake_tools//third_party/clang+llvm:ar"
DEFAULT_CCTOOL = "@com_etherealwake_tools//third_party/clang+llvm:cc"
DEFAULT_LINKTOOL = "@com_etherealwake_tools//third_party/clang+llvm:cxx"
DEFAULT_OBJCOPY = "@com_etherealwake_tools//third_party/clang+llvm:objcopy"
DEFAULT_STRIP = "@com_etherealwake_tools//third_party/clang+llvm:strip"

def clang_cc_toolchain_config(
        artool = DEFAULT_ARTOOL,
        cctool = DEFAULT_CCTOOL,
        compiler = "clang",
        linktool = DEFAULT_LINKTOOL,
        objcopy = DEFAULT_OBJCOPY,
        strip = DEFAULT_STRIP,
        **kwargs):
    return gcc_cc_toolchain_config(
        artool = artool,
        cctool = cctool,
        compiler = compiler,
        linktool = linktool,
        objcopy = objcopy,
        strip = strip,
        **kwargs
    )

def clang_toolchain(
        all_files = DEFAULT_ALLFILES,
        compiler_files = DEFAULT_ALLFILES,
        artool = DEFAULT_ARTOOL,
        cctool = DEFAULT_CCTOOL,
        compiler = "clang",
        linktool = DEFAULT_LINKTOOL,
        objcopy = DEFAULT_OBJCOPY,
        strip = DEFAULT_STRIP,
        **kwargs):
    """C/C++ Toolchain Macro for Generic Unix.

    Targets:
        {name}: Instance of `toolchain`.
        {name}-toolchain: Instance of `cc_toolchain`.
    """
    return gcc_toolchain(
        all_files = all_files,
        compiler_files = compiler_files,
        artool = artool,
        cctool = cctool,
        compiler = compiler,
        linktool = linktool,
        objcopy = objcopy,
        strip = strip,
        **kwargs
    )
