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
# Generic EABI
#

platform(
    name = "arm-none-eabi",
    constraint_values = [
        "//constraints/endian:little",
        "//constraints/float:soft",
    ],
    parents = ["//platforms:arm-none"],
)

platform(
    name = "arm-none-eabihf",
    constraint_values = [
        "//constraints/endian:little",
        "//constraints/float:hard",
    ],
    parents = ["//platforms:arm-none"],
)

platform(
    name = "armeb-none-eabi",
    constraint_values = [
        "//constraints/endian:big",
    ],
    parents = [":arm-none-eabi"],
)

platform(
    name = "armeb-none-eabihf",
    constraint_values = [
        "//constraints/endian:big",
    ],
    parents = [":arm-none-eabihf"],
)

#
# Cortex-A
#

platform(
    name = "armv7a-none-eabi",
    constraint_values = [
        "//constraints/arch/arm:armv7-a",
        "//constraints/arm/profile:application",
    ],
    parents = [":arm-none-eabi"],
)

platform(
    name = "armv7a-none-eabihf",
    constraint_values = [
        "//constraints/arch/arm:armv7-a",
        "//constraints/arm/profile:application",
    ],
    parents = [":arm-none-eabihf"],
)

#
# Cortex-M
#

platform(
    name = "armv6m-none-eabi",
    constraint_values = [
        "//constraints/arch/arm:armv6-m",
        "//constraints/arm/profile:microcontroller",
    ],
    parents = [":arm-none-eabi"],
)

platform(
    name = "cortex-m0",
    constraint_values = [
        "//constraints/core/arm:cortex-m0",
    ],
    parents = [":armv6m-none-eabi"],
)

platform(
    name = "cortex-m0plus",
    constraint_values = [
        "//constraints/core/arm:cortex-m0plus",
    ],
    parents = [":armv6m-none-eabi"],
)

platform(
    name = "cortex-m1",
    constraint_values = [
        "//constraints/core/arm:cortex-m1",
    ],
    parents = [":armv6m-none-eabi"],
)

platform(
    name = "armv7m-none-eabi",
    constraint_values = [
        "//constraints/arch/arm:armv7-m",
        "//constraints/arm/profile:microcontroller",
    ],
    parents = [":arm-none-eabi"],
)

platform(
    name = "cortex-m3",
    constraint_values = [
        "//constraints/core/arm:cortex-m3",
    ],
    parents = [":armv7m-none-eabi"],
)

platform(
    name = "armv7em-none-eabi",
    constraint_values = [
        "//constraints/arch/arm:armv7e-m",
        "//constraints/arm/profile:microcontroller",
    ],
    parents = [":arm-none-eabi"],
)

platform(
    name = "armv7em-none-eabihf",
    constraint_values = [
        "//constraints/arch/arm:armv7e-m",
        "//constraints/arm/profile:microcontroller",
    ],
    parents = [":arm-none-eabihf"],
)

platform(
    name = "cortex-m4",
    constraint_values = [
        "//constraints/core/arm:cortex-m4",
    ],
    parents = [":armv7em-none-eabi"],
)

platform(
    name = "cortex-m4f",
    constraint_values = [
        "//constraints/core/arm:cortex-m4",
    ],
    parents = [":armv7em-none-eabihf"],
)

platform(
    name = "cortex-m7",
    constraint_values = [
        "//constraints/core/arm:cortex-m7",
    ],
    parents = [":armv7em-none-eabi"],
)

platform(
    name = "cortex-m7f",
    constraint_values = [
        "//constraints/core/arm:cortex-m7",
    ],
    parents = [":armv7em-none-eabihf"],
)

#
# Cortex-R
#

platform(
    name = "armv7r-none-eabi",
    constraint_values = [
        "//constraints/arch/arm:armv7-r",
        "//constraints/arm/profile:realtime",
    ],
    parents = [":arm-none-eabi"],
)

platform(
    name = "armebv7r-none-eabi",
    constraint_values = [
        "//constraints/endian:big",
    ],
    parents = [":armv7r-none-eabi"],
)

platform(
    name = "armv7r-none-eabihf",
    constraint_values = [
        "//constraints/arch/arm:armv7-r",
        "//constraints/arm/profile:realtime",
    ],
    parents = [":arm-none-eabihf"],
)

platform(
    name = "armebv7r-none-eabihf",
    constraint_values = [
        "//constraints/endian:big",
    ],
    parents = [":armv7r-none-eabihf"],
)

platform(
    name = "cortex-r4",
    constraint_values = [
        "//constraints/core/arm:cortex-r4",
    ],
    parents = [":armv7r-none-eabi"],
)

platform(
    name = "cortex-r4f",
    constraint_values = [
        "//constraints/core/arm:cortex-r4",
    ],
    parents = [":armv7r-none-eabihf"],
)

platform(
    name = "cortex-r5",
    constraint_values = [
        "//constraints/core/arm:cortex-r5",
    ],
    parents = [":armv7r-none-eabi"],
)

platform(
    name = "cortex-r5f",
    constraint_values = [
        "//constraints/core/arm:cortex-r5",
    ],
    parents = [":armv7r-none-eabihf"],
)

platform(
    name = "cortex-r7",
    constraint_values = [
        "//constraints/core/arm:cortex-r7",
    ],
    parents = [":armv7r-none-eabi"],
)

platform(
    name = "cortex-r7f",
    constraint_values = [
        "//constraints/core/arm:cortex-r7",
    ],
    parents = [":armv7r-none-eabihf"],
)

platform(
    name = "cortex-r8",
    constraint_values = [
        "//constraints/core/arm:cortex-r8",
    ],
    parents = [":armv7r-none-eabi"],
)

platform(
    name = "cortex-r8f",
    constraint_values = [
        "//constraints/core/arm:cortex-r8",
    ],
    parents = [":armv7r-none-eabihf"],
)
