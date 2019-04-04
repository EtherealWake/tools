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

VERSION = "8.0.0"
_BUILD = "@com_etherealwake_tools//third_party/clang+llvm:repo.BUILD"
_PLATFORMS = "//conditions/platforms"
_URL = "http://releases.llvm.org/%s/" % VERSION

def _maybe(name, rule, **kwargs):
    if name not in native.existing_rules():
        rule(name = name, **kwargs)

def llvm_alias(name):
    native.alias(
        name = name,
        actual = select({
            _PLATFORMS + ":i386-freebsd": "@org_llvm_i386_freebsd//:" + name,
            _PLATFORMS + ":x86_64-freebsd": "@org_llvm_amd64_freebsd//:" + name,
            _PLATFORMS + ":i386-linux": "@org_llvm_i386_linux//:" + name,
            _PLATFORMS + ":x86_64-linux": "@org_llvm_amd64_linux//:" + name,
            _PLATFORMS + ":x86_64-macosx": "@org_llvm_amd64_darwin//:" + name,
            _PLATFORMS + ":i386-windows": "@org_llvm_i386_windows//:" + name,
            _PLATFORMS + ":x86_64-windows": "@org_llvm_amd64_windows//:" + name,
        }),
        tags = ["manual"],
    )

def llvm_dependencies():
    _maybe(
        name = "org_llvm_amd64_freebsd",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "af15d14bd25e469e35ed7c43cb7e035bc1b2aa7b55d26ad597a43e72768750a8",
        strip_prefix = "clang+llvm-8.0.0-amd64-unknown-freebsd11",
        url = _URL + "clang+llvm-8.0.0-amd64-unknown-freebsd11.tar.xz",
    )
    _maybe(
        name = "org_llvm_amd64_linux",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "9ef854b71949f825362a119bf2597f744836cb571131ae6b721cd102ffea8cd0",
        strip_prefix = "clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-14.04",
        url = _URL + "clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz",
    )
