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

VERSION = "12.0-RELEASE"
_BUILD = "@com_etherealwake_tools//third_party/freebsd-base:repo.BUILD"
_URL = "https://github.com/EtherealWake/freebsd-sysroot/releases/download/%s/" % VERSION

def _maybe(name, rule, **kwargs):
    if name not in native.existing_rules():
        rule(name = name, **kwargs)

def freebsd_dependencies():
    """Downloads sysroots for building FreeBSD executables.

    Targets:
        `@com_etherealwake_sysroot_freebsd_{machine}//:all_files`: All files in the sysroot
        `@com_etherealwake_sysroot_freebsd_{machine}//:sysroot`: Directory for the sysroot
    """
    _maybe(
        name = "com_etherealwake_sysroot_freebsd_amd64",
        build_file = _BUILD,
        sha256 = "4731c13b51febd8872ec04afc4832919912ffb40aa6342ab7bc459c467c6b99b",
        rule = http_archive,
        url = _URL + "FreeBSD-%s-amd64-sysroot.tar.xz" % VERSION,
    )
    _maybe(
        name = "com_etherealwake_sysroot_freebsd_arm64",
        build_file = _BUILD,
        sha256 = "8ffb3f185af2ac225c292c4a02efd8fe06fe2c568b40b04b707528f802a66f9f",
        rule = http_archive,
        url = _URL + "FreeBSD-%s-arm64-aarch64-sysroot.tar.xz" % VERSION,
    )
    _maybe(
        name = "com_etherealwake_sysroot_freebsd_armv7",
        build_file = _BUILD,
        sha256 = "2b2199b95697f98758f506ee09ea396df503a5fa8beccce05ad248a861a974c1",
        rule = http_archive,
        url = _URL + "FreeBSD-%s-arm-armv7-sysroot.tar.xz" % VERSION,
    )
    _maybe(
        name = "com_etherealwake_sysroot_freebsd_i386",
        build_file = _BUILD,
        sha256 = "ef748c7ef446c7b2255327d3dd2c76fe0006f8401c8e77ada42180536bc41d4b",
        rule = http_archive,
        url = _URL + "FreeBSD-%s-i386-sysroot.tar.xz" % VERSION,
    )
