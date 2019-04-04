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
load(":repo.bzl", "arm_alias")

package(default_visibility = ["//visibility:public"])

licenses(["restricted"])  # GPLv3

#
# Everything
#

# All Files in Package
arm_alias(name = "all_files")

# Files Required for Cross-Compiling
arm_alias(name = "compiler_files")

# Headers and Libraries from Newlib
arm_alias(name = "newlib_files")

# Headers from Newlib
arm_alias(name = "newlib_includes")

# Libraries from Newlib
arm_alias(name = "newlib_libraries")

# Built-In Root Directory for Includes/Libraries
arm_alias(name = "sysroot")

#
# Individual Tools
#

# Archiver
arm_alias(name = "ar")

# C/C++ Compiler
arm_alias(name = "cc")

# Process Coverage Information
arm_alias(name = "cov")

# C Preprocessor
arm_alias(name = "cpp")

# C++ Compiler
arm_alias(name = "cxx")

# Linker
arm_alias(name = "ld")

# Display Symbolic Information
arm_alias(name = "nm")

# Copy and Translate Object Files
arm_alias(name = "objcopy")

# Display Information from Object Files
arm_alias(name = "objdump")

# Discard Information
arm_alias(name = "strip")
