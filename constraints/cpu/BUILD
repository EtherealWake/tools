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
    name = "cpu",
    actual = "@platforms//cpu",
)

# NOTE: Semi-Deprecated Upstream
alias(
    name = "aarch64",
    actual = "@platforms//cpu:aarch64",
)

# NOTE: Semi-Deprecated Upstream
alias(
    name = "arm",
    actual = "@platforms//cpu:arm",
)

constraint_value(
    name = "mips",
    constraint_setting = ":cpu",
)

constraint_value(
    name = "mips64",
    constraint_setting = ":cpu",
)

constraint_value(
    name = "powerpc",
    constraint_setting = ":cpu",
)

alias(
    name = "powerpc64",
    actual = "@platforms//cpu:ppc",
)

alias(
    name = "s390x",
    actual = "@platforms//cpu:s390x",
)

alias(
    name = "x86_32",
    actual = "@platforms//cpu:x86_32",
)

alias(
    name = "x86_64",
    actual = "@platforms//cpu:x86_64",
)
