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

VERSION = "9.0.0"
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
            _PLATFORMS + ":i386-unknown-freebsd": "@org_llvm_i386_freebsd//:" + name,
            _PLATFORMS + ":x86_64-unknown-freebsd": "@org_llvm_amd64_freebsd//:" + name,
            _PLATFORMS + ":x86_64-pc-linux-gnu": "@org_llvm_amd64_linux//:" + name,
            _PLATFORMS + ":x86_64-apple-macos": "@org_llvm_amd64_darwin//:" + name,
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
        sha256 = "2a1f123a9d992c9719ef7677e127182ca707a5984a929f1c3f34fbb95ffbf6f3",
        strip_prefix = "clang+llvm-%s-amd64-unknown-freebsd11" % VERSION,
        url = _URL + "clang+llvm-%s-amd64-unknown-freebsd11.tar.xz" % VERSION,
    )
    _maybe(
        name = "org_llvm_amd64_linux",
        build_file = _BUILD,
        rule = http_archive,
        sha256 = "bea706c8f6992497d08488f44e77b8f0f87f5b275295b974aa8b194efba18cb8",
        strip_prefix = "clang+llvm-%s-x86_64-linux-gnu-ubuntu-14.04" % VERSION,
        url = _URL + "clang+llvm-%s-x86_64-linux-gnu-ubuntu-14.04.tar.xz" % VERSION,
    )
