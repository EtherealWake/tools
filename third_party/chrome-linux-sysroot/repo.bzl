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

# Platform List per 2018-10-09 (SHA 0cfed476d64a43d88b67b4e092b6d30e662ea142)
DATE = "2018-10-09"
VERSION = "0cfed476d64a43d88b67b4e092b6d30e662ea142"
_BUILD = "@com_etherealwake_tools//third_party/chrome-linux-sysroot:repo.BUILD"
_URL = "https://commondatastorage.googleapis.com/chrome-linux-sysroot/toolchain/"

def _maybe(name, rule, **kwargs):
    if name not in native.existing_rules():
        rule(name = name, **kwargs)

def linux_dependencies():
    """Downloads sysroots for building Linux executables.

    Targets:
        `@org_chromium_sysroot_linux_{machine}//:all_files`: All files in the sysroot
        `@org_chromium_sysroot_linux_{machine}//:sysroot`: Directory for the sysroot
    """
    _maybe(
        name = "org_chromium_sysroot_linux_amd64",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "6964fc4327837d4eab3799a29d843b9cdd6b68edfdce170e1a40ca723f4ad6c5",
        url = _URL + "e7c53f04bd88d29d075bfd1f62b073aeb69cbe09/debian_sid_amd64_sysroot.tar.xz",
    )
    _maybe(
        name = "org_chromium_sysroot_linux_arm",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "87b371abaed9aaa4cc7e204d7418d7a72f99e8e47cc20aa1c084e33f39909160",
        url = _URL + "ef5c4f84bcafb7a3796d36bb1db7826317dde51c/debian_sid_arm_sysroot.tar.xz",
    )
    _maybe(
        name = "org_chromium_sysroot_linux_arm64",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "bd4943c8d819a3be7a69f1af5031ae59f077b74133bc5ce9cfa10384ad919e4f",
        url = _URL + "953c2471bc7e71a788309f6c2d2003e8b703305d/debian_sid_arm64_sysroot.tar.xz",
    )
    _maybe(
        name = "org_chromium_sysroot_linux_i386",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "11ffdbd31f20db4bfa5138dc4eb95ed04cb9868b556a04960f03b8b455dd1daf",
        url = _URL + "9e6279438ece6fb42b5333ca90d5e9d0c188a403/debian_sid_i386_sysroot.tar.xz",
    )
    _maybe(
        name = "org_chromium_sysroot_linux_mips",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "1609c671cb872976b927b53b12ec884eaa5efe710dc6efdc47e1d3f5a8f66607",
        url = _URL + "958731a68a169631c0450efb15410ccc4135ef2a/debian_sid_mips_sysroot.tar.xz",
    )
    _maybe(
        name = "org_chromium_sysroot_linux_mips64el",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "b33f0f376f2a0b716f478d8843b273761e96d04b463e28d0f8ad35629df3af98",
        url = _URL + "51ca1f4092ac76ad1a1da953f0f3ce1aea947a42/debian_sid_mips64el_sysroot.tar.xz",
    )
