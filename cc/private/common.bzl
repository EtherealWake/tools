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
"""Common Constants and Routines for C/C++ Toolchain Construction."""

load(
    "@bazel_tools//tools/build_defs/cc:action_names.bzl",
    _ACTION_NAMES = "ACTION_NAMES",
)
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "with_feature_set",
)

#
# Constants
#

# Names of All C/C++ Toolchain Actions.
ACTION_NAMES = _ACTION_NAMES

# Names of All C/C++ Toolchain Features.
FEATURE_NAMES = struct(
    # Compilation Mode
    dbg = "dbg",
    fastbuild = "fastbuild",
    opt = "opt",
    # Linking Mode
    dynamic_linking_mode = "dynamic_linking_mode",
    static_linking_mode = "static_linking_mode",
    # Official Features
    fully_static_link = "fully_static_link",
    no_legacy_features = "no_legacy_features",
    no_stripping = "no_stripping",
    parse_showincludes = "parse_showincludes",
    per_object_debug_info = "per_object_debug_info",
    static_link_cpp_runtimes = "static_link_cpp_runtimes",
    supports_dynamic_linker = "supports_dynamic_linker",
    supports_fission = "supports_fission",
    supports_interface_shared_libraries = "supports_interface_shared_libraries",
    supports_pic = "supports_pic",
    supports_start_end_lib = "supports_start_end_lib",
    # Common/Legacy Features
    archiver_flags = "archiver_flags",
    compiler_input_flags = "compiler_input_flags",
    compiler_output_flags = "compiler_output_flags",
    def_file = "def_file",
    default_compile_flags = "default_compile_flags",
    default_link_flags = "default_link_flags",
    dependency_file = "dependency_file",
    fission_support = "fission_support",
    force_pic_flags = "force_pic_flags",
    includes = "includes",
    include_paths = "include_paths",
    libraries_to_link = "libraries_to_link",
    library_search_directories = "library_search_directories",
    linkstamps = "linkstamps",
    linker_param_file = "linker_param_file",
    msvc_env = "msvc_env",
    nologo = "nologo",
    objcopy_embed_flags = "objcopy_embed_flags",
    output_execpath_flags = "output_execpath_flags",
    pic = "pic",
    preprocessor_defines = "preprocessor_defines",
    random_seed = "random_seed",
    runtime_library_search_directories = "runtime_library_search_directories",
    shared_flag = "shared_flag",
    static_libgcc = "static_libgcc",
    strip_debug_symbols = "strip_debug_symbols",
    sysroot = "sysroot",
    user_compile_flags = "user_compile_flags",
    user_link_flags = "user_link_flags",
    unfiltered_compile_flags = "unfiltered_compile_flags",
)

# C/C++ Toolchain Action Names for Object-Generating Operations.
ALL_COMPILE_ACTIONS = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
]

# C/C++ Toolchain Action Names for Assembler Operations.
ASM_COMPILE_ACTIONS = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
]

# C/C++ Toolchain Action Names for C Compilation Operations.
C_COMPILE_ACTIONS = [
    ACTION_NAMES.c_compile,
]

# C/C++ Toolchain Action Names for C++ Compilation Operations.
CPP_COMPILE_ACTIONS = [
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
]

# C/C++ Toolchain Action Names for Preprocessing Operations.
PREPROCESSOR_ACTIONS = [
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
]

# C/C++ Toolchain Action Names for Linking Operations.
ALL_LINK_ACTIONS = [
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
    ACTION_NAMES.cpp_link_executable,
]

#
# General Functions
#

def make_flag_set(actions, flags, with_features = [], **kwargs):
    """Constructs a `flag_set` for the specified action and flags.

    Args:
        actions: Actions covered by the `flag_set`.
        flags: Flags for the `flag_group`.
        kwargs: Additional arguments for the `flag_group` instance.

    Returns:
        Empty list if `flags` is empty; otherwise, an list containing a
        single instance of `flag_set` combining `actions` and `flags`.
    """
    if not flags:
        return []
    return [flag_set(
        actions = actions,
        flag_groups = [flag_group(flags = flags, **kwargs)],
        with_features = with_features,
    )]

def make_mode_flag_set(ctx, name):
    """Constructs a `flag_set` for the specific compilation mode."""
    modes = ctx.attr.modes
    flag_sets = []
    flag_sets += make_flag_set(
        ALL_COMPILE_ACTIONS,
        modes.get(name, []) + modes.get(name + ".copts", []),
        with_features = [with_feature_set(features = [name])],
    )
    flag_sets += make_flag_set(
        ASM_COMPILE_ACTIONS,
        modes.get(name, []) + modes.get(name + ".asmopts", []),
        with_features = [with_feature_set(features = [name])],
    )
    flag_sets += make_flag_set(
        C_COMPILE_ACTIONS,
        modes.get(name, []) + modes.get(name + ".conlyopts", []),
        with_features = [with_feature_set(features = [name])],
    )
    flag_sets += make_flag_set(
        CPP_COMPILE_ACTIONS,
        modes.get(name, []) + modes.get(name + ".cxxopts", []),
        with_features = [with_feature_set(features = [name])],
    )
    return flag_sets

def make_tool(ctx, path, **kwargs):
    """Constructs a `tool` for the specified File.

    CROSSTOOL requires that paths be relative to the package defining the
    toolchain.  This function will take a `File` input and encode its path to
    meet this requirement.

    Args:
        ctx: `ctx` object from the rule implementation.
        path: `File` object to analyze.
        kwargs: Additional arguments for the `tool` instance.

    Returns:
        List with a single instance of `tool`.
    """
    depth = ctx.build_file_path.count("/")
    if path and hasattr(path, "path"):
        path = ("../" * depth) + path.path
    return [tool(path = path, **kwargs)]

#
# Common Feature Sets
#

def make_default_compile_flags_feature(ctx, copts = []):
    copts = copts + ctx.attr.copts
    modes = ctx.attr.modes
    return feature(
        name = FEATURE_NAMES.default_compile_flags,
        flag_sets = make_flag_set(ALL_COMPILE_ACTIONS, copts) +
                    make_flag_set(ASM_COMPILE_ACTIONS, ctx.attr.asmopts) +
                    make_flag_set(C_COMPILE_ACTIONS, ctx.attr.conlyopts) +
                    make_flag_set(CPP_COMPILE_ACTIONS, ctx.attr.cxxopts) +
                    make_mode_flag_set(ctx, "dbg") +
                    make_mode_flag_set(ctx, "fastbuild") +
                    make_mode_flag_set(ctx, "opt"),
    )

def make_default_link_flags_feature(ctx, linkopts = []):
    linkopts = linkopts + ctx.attr.linkopts
    modes = ctx.attr.modes
    dbg = make_flag_set(
        ALL_LINK_ACTIONS,
        modes.get("dbg", []) + modes.get("dbg.linkopts", []),
        with_features = [with_feature_set(features = ["dbg"])],
    )
    fast = make_flag_set(
        ALL_LINK_ACTIONS,
        modes.get("fastbuild", []) + modes.get("fastbuild.linkopts", []),
        with_features = [with_feature_set(features = ["fastbuild"])],
    )
    opt = make_flag_set(
        ALL_LINK_ACTIONS,
        modes.get("opt", []) + modes.get("opt.linkopts", []),
        with_features = [with_feature_set(features = ["opt"])],
    )
    return feature(
        name = FEATURE_NAMES.default_link_flags,
        flag_sets = make_flag_set(ALL_LINK_ACTIONS, linkopts) +
                    dbg + fast + opt,
    )

def make_linkstamps_feature(ctx):
    return feature(
        name = FEATURE_NAMES.linkstamps,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "linkstamp_paths",
                iterate_over = "linkstamp_paths",
                flags = ["%{linkstamp_paths}"],
            )],
        )],
    )

def make_unfiltered_compile_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.unfiltered_compile_flags,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "unfiltered_compile_flags",
                iterate_over = "unfiltered_compile_flags",
                flags = ["%{unfiltered_compile_flags}"],
            )],
        )],
    )

def make_user_compile_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.user_compile_flags,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "user_compile_flags",
                iterate_over = "user_compile_flags",
                flags = ["%{user_compile_flags}"],
            )],
        )],
    )

def make_user_link_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.user_link_flags,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "user_link_flags",
                iterate_over = "user_link_flags",
                flags = ["%{user_link_flags}"],
            )],
        )],
    )
