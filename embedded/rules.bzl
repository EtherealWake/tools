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
"""Rules for Embedded Builds."""

load("//cc:rules.bzl", "cc_binary", "cc_library")

#
# Embedded Transition
#

SETTING_PLATFORMS = "//command_line_option:platforms"

def _embedded_transition_impl(settings, attr):
    platform = attr.platform
    return {
        SETTING_PLATFORMS: str(platform),
    }

embedded_transition = transition(
    implementation = _embedded_transition_impl,
    inputs = [],
    outputs = [SETTING_PLATFORMS],
)

#
# Embedded Binaries
#

def _embedded_binary_impl(ctx):
    return [DefaultInfo(
        files = depset(ctx.files.deps),
        data_runfiles = ctx.runfiles(collect_data = True),
        default_runfiles = ctx.runfiles(collect_default = True),
    )]

_embedded_binary = rule(
    attrs = {
        "platform": attr.label(
            providers = [platform_common.PlatformInfo],
        ),
        "deps": attr.label_list(
            allow_files = True,
        ),
        "_whitelist_function_transition": attr.label(
            default = "@//tools/whitelists/function_transition_whitelist",
        ),
    },
    cfg = embedded_transition,
    implementation = _embedded_binary_impl,
)

def embedded_binary(
        name,
        platform,
        tags = None,
        testonly = False,
        visibility = None,
        **kwargs):
    """Builds a binary for an embedded platform.

    Args:
        name: (Name; required) Unique identifier for the rule.  The resulting
            binary will be named according to this attribute.
        platform: (Label; required) Identifies the target `platform` for the
            binary.
        **kwargs: Standard arguments for `cc_binary`.
    """
    cc_binary(
        name = name + ".elf",
        tags = ["manual"],
        testonly = testonly,
        visibility = ["//visibility:private"],
        **kwargs
    )
    _embedded_binary(
        name = name,
        deps = [":%s.elf" % name],
        platform = platform,
        tags = tags,
        testonly = testonly,
        visibility = visibility,
    )

#
# Embedded Stubs
#

def embedded_library(name, tags = [], **kwargs):
    # Ensure this does not break `bazel build ...`
    if "manual" not in tags:
        tags = ["manual"] + tags
    cc_library(
        name = name,
        tags = tags,
        **kwargs
    )

def embedded_test(testonly = True, **kwargs):
    # Ensure this does not break `bazel build ...`
    return embedded_binary(
        testonly = testonly,
        **kwargs
    )
