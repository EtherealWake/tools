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
package(default_visibility = ["//visibility:public"])

alias(
    name = "os",
    actual = "@bazel_tools//platforms:os",
)

alias(
    name = "android",
    actual = "@bazel_tools//platforms:android",
)

constraint_value(
    name = "dragonfly",
    constraint_setting = ":os",
)

alias(
    name = "freebsd",
    actual = "@bazel_tools//platforms:freebsd",
)

alias(
    name = "ios",
    actual = "@bazel_tools//platforms:ios",
)

alias(
    name = "linux",
    actual = "@bazel_tools//platforms:linux",
)

alias(
    name = "macos",
    actual = "@bazel_tools//platforms:osx",
)

constraint_value(
    name = "netbsd",
    constraint_setting = ":os",
)

constraint_value(
    name = "none",
    constraint_setting = ":os",
)

constraint_value(
    name = "openbsd",
    constraint_setting = ":os",
)

alias(
    name = "windows",
    actual = "@bazel_tools//platforms:windows",
)
