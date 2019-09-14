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
"""Aliases for Built-In C/C++ Rules"""

load(
    "@rules_cc//cc:defs.bzl",
    _cc_binary = "cc_binary",
    _cc_import = "cc_import",
    _cc_library = "cc_library",
    _cc_proto_library = "cc_proto_library",
    _cc_test = "cc_test",
    _cc_toolchain = "cc_toolchain",
    _cc_toolchain_suite = "cc_toolchain_suite",
    _fdo_prefetch_hints = "fdo_prefetch_hints",
    _fdo_profile = "fdo_profile",
)

cc_binary = _cc_binary
cc_import = _cc_import
cc_library = _cc_library
cc_proto_library = _cc_proto_library
cc_test = _cc_test
cc_toolchain = _cc_toolchain
cc_toolchain_suite = _cc_toolchain_suite
fdo_prefetch_hints = _fdo_prefetch_hints
fdo_profile = _fdo_profile
