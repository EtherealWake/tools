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

#
# Dragonfly BSD
#

config_setting(
    name = "x86_64-pc-dragonfly",
    constraint_values = [
        "//constraints/cpu:x86_64",
        "//constraints/os:dragonfly",
    ],
)

#
# FreeBSD
#

config_setting(
    name = "aarch64-unknown-freebsd",
    constraint_values = [
        "//constraints/cpu:aarch64",
        "//constraints/os:freebsd",
    ],
)

config_setting(
    name = "armv7-gnueabihf-freebsd",
    constraint_values = [
        "//constraints/arch/arm:armv7-a",
        "//constraints/cpu:arm",
        "//constraints/float:hard",
        "//constraints/os:freebsd",
    ],
)

config_setting(
    name = "i386-unknown-freebsd",
    constraint_values = [
        "//constraints/cpu:x86_32",
        "//constraints/os:freebsd",
    ],
)

config_setting(
    name = "x86_64-unknown-freebsd",
    constraint_values = [
        "//constraints/cpu:x86_64",
        "//constraints/os:freebsd",
    ],
)

#
# Linux
#

config_setting(
    name = "aarch64-unknown-linux-gnu",
    constraint_values = [
        "//constraints/cpu:aarch64",
        "//constraints/os:linux",
    ],
)

config_setting(
    name = "armv7a-unknown-linux-gnueabihf",
    constraint_values = [
        "//constraints/arch/arm:armv7-a",
        "//constraints/cpu:arm",
        "//constraints/float:hard",
        "//constraints/os:linux",
    ],
)

config_setting(
    name = "i686-pc-linux-gnu",
    constraint_values = [
        "//constraints/cpu:x86_32",
        "//constraints/os:linux",
    ],
)

config_setting(
    name = "x86_64-pc-linux-gnu",
    constraint_values = [
        "//constraints/cpu:x86_64",
        "//constraints/os:linux",
    ],
)

#
# Mac OS X (Darwin)
#

config_setting(
    name = "x86_64-apple-macos",
    constraint_values = [
        "//constraints/cpu:x86_64",
        "//constraints/os:macos",
    ],
)

#
# NetBSD
#

config_setting(
    name = "aarch64-unknown-netbsd",
    constraint_values = [
        "//constraints/cpu:aarch64",
        "//constraints/os:netbsd",
    ],
)

config_setting(
    name = "armv7-unknown-netbsdelf-eabihf",
    constraint_values = [
        "//constraints/arch/arm:armv7-a",
        "//constraints/cpu:arm",
        "//constraints/float:hard",
        "//constraints/os:netbsd",
    ],
)

config_setting(
    name = "i386-unknown-netbsdelf",
    constraint_values = [
        "//constraints/cpu:x86_32",
        "//constraints/os:netbsd",
    ],
)

config_setting(
    name = "x86_64-unknown-netbsd",
    constraint_values = [
        "//constraints/cpu:x86_64",
        "//constraints/os:netbsd",
    ],
)

#
# OpenBSD
#

config_setting(
    name = "amd64-unknown-openbsd",
    constraint_values = [
        "//constraints/cpu:x86_64",
        "//constraints/os:openbsd",
    ],
)

config_setting(
    name = "aarch64-unknown-openbsd",
    constraint_values = [
        "//constraints/cpu:aarch64",
        "//constraints/os:openbsd",
    ],
)

config_setting(
    name = "arm-unknown-openbsd",
    constraint_values = [
        "//constraints/cpu:arm",
        "//constraints/os:openbsd",
    ],
)

config_setting(
    name = "i386-unknown-openbsd",
    constraint_values = [
        "//constraints/cpu:x86_32",
        "//constraints/os:openbsd",
    ],
)

#
# Embedded/Freestanding
#

config_setting(
    name = "arm-none",
    constraint_values = [
        "//constraints/cpu:arm",
        "//constraints/os:none",
    ],
)

#
# Windows
#

config_setting(
    name = "aarch64-windows",
    constraint_values = [
        "//constraints/cpu:aarch64",
        "//constraints/os:windows",
    ],
)

config_setting(
    name = "arm-windows",
    constraint_values = [
        "//constraints/cpu:arm",
        "//constraints/os:windows",
    ],
)

config_setting(
    name = "i386-windows",
    constraint_values = [
        "//constraints/cpu:x86_32",
        "//constraints/os:windows",
    ],
)

config_setting(
    name = "x86_64-windows",
    constraint_values = [
        "//constraints/cpu:x86_64",
        "//constraints/os:windows",
    ],
)
