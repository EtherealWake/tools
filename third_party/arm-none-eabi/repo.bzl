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

VERSION = "9-2019-q4-major"
_BUILD = "@com_etherealwake_tools//third_party/arm-none-eabi:repo.BUILD"
_PLATFORMS = "@com_etherealwake_tools//conditions/platforms"
_URL = "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/RC2.1/"

def _maybe(name, rule, **kwargs):
    if name not in native.existing_rules():
        rule(name = name, **kwargs)

def arm_alias(name):
    native.alias(
        name = name,
        actual = select({
            _PLATFORMS + ":i386-windows": "@arm_none_eabi_win32//:" + name,
            # No native FreeBSD version available.  Use Linux emulation.
            _PLATFORMS + ":x86_64-unknown-freebsd": "@arm_none_eabi_linux//:" + name,
            _PLATFORMS + ":x86_64-pc-linux-gnu": "@arm_none_eabi_linux//:" + name,
            _PLATFORMS + ":x86_64-apple-macos": "@arm_none_eabi_mac//:" + name,
            _PLATFORMS + ":x86_64-windows": "@arm_none_eabi_win32//:" + name,
        }),
        tags = ["manual"],
    )

def arm_dependencies():
    _maybe(
        name = "arm_none_eabi_linux",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "bcd840f839d5bf49279638e9f67890b2ef3a7c9c7a9b25271e83ec4ff41d177a",
        strip_prefix = "gcc-arm-none-eabi-%s" % VERSION,
        url = _URL + "gcc-arm-none-eabi-%s-x86_64-linux.tar.bz2" % VERSION,
    )
