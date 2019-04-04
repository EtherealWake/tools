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
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

VERSION = "8-2018-q4-major"
_BUILD = "@com_etherealwake_tools//third_party/arm-none-eabi:repo.BUILD"
_PLATFORMS = "@com_etherealwake_tools//conditions/platforms"
_URL = "https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/"

def _maybe(name, rule, **kwargs):
    if name not in native.existing_rules():
        rule(name = name, **kwargs)

def arm_alias(name):
    native.alias(
        name = name,
        actual = select({
            _PLATFORMS + ":i386-windows": "@arm_none_eabi_win32//:" + name,
            # No native FreeBSD version available.  Use Linux emulation.
            _PLATFORMS + ":x86_64-freebsd": "@arm_none_eabi_linux//:" + name,
            _PLATFORMS + ":x86_64-linux": "@arm_none_eabi_linux//:" + name,
            _PLATFORMS + ":x86_64-macosx": "@arm_none_eabi_mac//:" + name,
            _PLATFORMS + ":x86_64-windows": "@arm_none_eabi_win32//:" + name,
        }),
        tags = ["manual"],
    )

def arm_dependencies():
    _maybe(
        name = "arm_none_eabi_linux",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "fb31fbdfe08406ece43eef5df623c0b2deb8b53e405e2c878300f7a1f303ee52",
        strip_prefix = "gcc-arm-none-eabi-8-2018-q4-major",
        url = _URL + "gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2",
    )
