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
"""Common Implementation of GCC-Compatible C/C++ Toolchain."""

load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "action_config",
    "artifact_name_pattern",
    "feature",
    "flag_group",
    "flag_set",
    "variable_with_value",
    "with_feature_set",
)
load(
    ":common.bzl",
    "ACTION_NAMES",
    "ALL_COMPILE_ACTIONS",
    "ALL_LINK_ACTIONS",
    "CPP_COMPILE_ACTIONS",
    "FEATURE_NAMES",
    "PREPROCESSOR_ACTIONS",
    "make_default_compile_flags_feature",
    "make_default_link_flags_feature",
    "make_linkstamps_feature",
    "make_tool",
    "make_user_compile_flags_feature",
    "make_user_link_flags_feature",
)
load("//cc:rules.bzl", "cc_toolchain")

#
# GCC-Compatible Features
#

def gcc_archiver_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.archiver_flags,
        flag_sets = [flag_set(
            actions = [ACTION_NAMES.cpp_link_static_library],
            flag_groups = [flag_group(
                flags = ["rcsD", "%{output_execpath}"],
            ), flag_group(
                iterate_over = "libraries_to_link",
                flag_groups = [flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "object_file",
                    ),
                    flags = ["%{libraries_to_link.name}"],
                ), flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "object_file_group",
                    ),
                    iterate_over = "libraries_to_link.object_files",
                    flags = ["%{libraries_to_link.object_files}"],
                )],
            )],
        )],
    )

def gcc_compiler_input_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.compiler_input_flags,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(flags = ["-c", "%{source_file}"])],
        )],
    )

def gcc_compiler_output_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.compiler_output_flags,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(flags = ["-o", "%{output_file}"])],
        )],
    )

def gcc_dependency_file_feature(ctx):
    return feature(
        name = FEATURE_NAMES.dependency_file,
        enabled = True,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "dependency_file",
                flags = ["-MD", "-MF", "%{dependency_file}"],
            )],
        )],
    )

def gcc_fission_support(ctx):
    return feature(
        name = FEATURE_NAMES.fission_support,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "is_using_fission",
                flags = ["-Wl,--gdb-index"],
            )],
        )],
    )

def gcc_force_pic_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.force_pic_flags,
        flag_sets = [flag_set(
            actions = [ACTION_NAMES.cpp_link_executable],
            flag_groups = [flag_group(
                expand_if_available = "force_pic",
                flags = ["-pie"],
            )],
        )],
    )

def gcc_fully_static_link(ctx):
    return feature(
        name = FEATURE_NAMES.fully_static_link,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(flags = ["-static"])],
        )],
    )

def gcc_includes_feature(ctx):
    return feature(
        name = FEATURE_NAMES.includes,
        enabled = True,
        flag_sets = [flag_set(
            actions = PREPROCESSOR_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "includes",
                iterate_over = "includes",
                flags = ["-include", "%{includes}"],
            )],
        )],
    )

def gcc_include_paths_feature(ctx):
    return feature(
        name = FEATURE_NAMES.include_paths,
        enabled = True,
        flag_sets = [flag_set(
            actions = PREPROCESSOR_ACTIONS,
            flag_groups = [flag_group(
                iterate_over = "quote_include_paths",
                flags = ["-iquote", "%{quote_include_paths}"],
            ), flag_group(
                iterate_over = "include_paths",
                flags = ["-I%{include_paths}"],
            ), flag_group(
                iterate_over = "system_include_paths",
                flags = ["-isystem", "%{system_include_paths}"],
            )],
        )],
    )

def gcc_libraries_to_link_feature(ctx):
    whole_archive = flag_group(
        expand_if_true = "libraries_to_link.is_whole_archive",
        flags = ["-Wl,--whole-archive"],
    )
    no_whole_archive = flag_group(
        expand_if_true = "libraries_to_link.is_whole_archive",
        flags = ["-Wl,--no-whole-archive"],
    )
    return feature(
        name = FEATURE_NAMES.libraries_to_link,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                iterate_over = "libraries_to_link",
                flag_groups = [flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "dynamic_library",
                    ),
                    flags = ["-l%{libraries_to_link.name}"],
                ), flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "interface_library",
                    ),
                    flags = ["%{libraries_to_link.name}"],
                ), flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "object_file",
                    ),
                    flags = ["%{libraries_to_link.name}"],
                ), flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "object_file_group",
                    ),
                    flag_groups = [
                        whole_archive,
                        flag_group(flags = ["-Wl,--start-lib"]),
                        flag_group(
                            iterate_over = "libraries_to_link.object_files",
                            flags = ["%{libraries_to_link.object_files}"],
                        ),
                        flag_group(flags = ["-Wl,--end-lib"]),
                        no_whole_archive,
                    ],
                ), flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "static_library",
                    ),
                    flag_groups = [
                        whole_archive,
                        flag_group(flags = ["%{libraries_to_link.name}"]),
                        no_whole_archive,
                    ],
                ), flag_group(
                    expand_if_equal = variable_with_value(
                        "libraries_to_link.type",
                        "versioned_dynamic_library",
                    ),
                    flags = ["-l:%{libraries_to_link.name}"],
                )],
            )],
        )],
    )

def gcc_library_search_directories_feature(ctx):
    return feature(
        name = FEATURE_NAMES.library_search_directories,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "library_search_directories",
                iterate_over = "library_search_directories",
                flags = ["-L%{library_search_directories}"],
            )],
        )],
    )

def gcc_linker_param_file_feature(ctx):
    return feature(
        name = FEATURE_NAMES.linker_param_file,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS + [ACTION_NAMES.cpp_link_static_library],
            flag_groups = [flag_group(
                expand_if_available = "linker_param_file",
                flags = ["@%{linker_param_file}"],
            )],
        )],
    )

def gcc_output_execpath_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.output_execpath_flags,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                flags = ["-o", "%{output_execpath}"],
            )],
        )],
    )

def gcc_per_object_debug_info_feature(ctx):
    return feature(
        name = FEATURE_NAMES.per_object_debug_info,
        enabled = True,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "per_object_debug_info_file",
                flags = ["-gsplit-dwarf"],
            )],
        )],
    )

def gcc_pic_feature(ctx):
    return feature(
        name = FEATURE_NAMES.pic,
        enabled = True,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "pic",
                flags = ["-fPIC"],
            )],
        )],
    )

def gcc_preprocessor_defines_feature(ctx):
    return feature(
        name = FEATURE_NAMES.preprocessor_defines,
        enabled = True,
        flag_sets = [flag_set(
            actions = PREPROCESSOR_ACTIONS,
            flag_groups = [flag_group(
                iterate_over = "preprocessor_defines",
                flags = ["-D%{preprocessor_defines}"],
            )],
        )],
    )

def gcc_random_seed_feature(ctx):
    return feature(
        name = FEATURE_NAMES.random_seed,
        enabled = True,
        flag_sets = [flag_set(
            actions = CPP_COMPILE_ACTIONS,
            flag_groups = [flag_group(flags = ["-frandom-seed=%{output_file}"])],
        )],
    )

def gcc_runtime_library_search_directories_feature(ctx):
    origin = "-Wl,-rpath,$ORIGIN/"
    return feature(
        name = FEATURE_NAMES.runtime_library_search_directories,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "runtime_library_search_directories",
                iterate_over = "runtime_library_search_directories",
                flags = [origin + "%{runtime_library_search_directories}"],
            )],
        )],
    )

def gcc_shared_flag_feature(ctx):
    return feature(
        name = FEATURE_NAMES.shared_flag,
        flag_sets = [flag_set(
            actions = [
                ACTION_NAMES.cpp_link_dynamic_library,
                ACTION_NAMES.cpp_link_nodeps_dynamic_library,
            ],
            flag_groups = [flag_group(flags = ["-shared"])],
        )],
    )

def gcc_static_libgcc_feature(ctx):
    return feature(
        name = FEATURE_NAMES.static_libgcc,
        enabled = True,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            with_features = [with_feature_set(features = [
                FEATURE_NAMES.static_link_cpp_runtimes,
            ])],
            flag_groups = [flag_group(flags = ["-static-libgcc"])],
        )],
    )

def gcc_strip_debug_symbols_feature(ctx):
    return feature(
        name = FEATURE_NAMES.strip_debug_symbols,
        flag_sets = [flag_set(
            actions = ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "strip_debug_symbols",
                flags = ["-Wl,-S"],
            )],
        )],
    )

def gcc_strip_flag_set(ctx, **kwargs):
    """Generates list of `flag_set` for the `strip` executable."""
    return [flag_set(
        flag_groups = [flag_group(
            flags = ctx.attr.stripopts,
        ), flag_group(
            flags = ["%{stripopts}"],
            iterate_over = "stripopts",
        ), flag_group(
            flags = ["-o", "%{output_file}", "%{input_file}"],
        )],
        **kwargs
    )]

def gcc_sysroot_feature(ctx):
    return feature(
        name = FEATURE_NAMES.sysroot,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS + ALL_LINK_ACTIONS,
            flag_groups = [flag_group(
                expand_if_available = "sysroot",
                flags = ["--sysroot=%{sysroot}"],
            )],
        )],
    )

def gcc_unfiltered_compile_flags_feature(ctx):
    return feature(
        name = FEATURE_NAMES.unfiltered_compile_flags,
        enabled = True,
        flag_sets = [flag_set(
            actions = ALL_COMPILE_ACTIONS,
            flag_groups = [flag_group(flags = [
                "-no-canonical-prefixes",
                "-Wno-builtin-macro-redefined",
                "-D__DATE__=\"redacted\"",
                "-D__TIME__=\"redacted\"",
                "-D__TIMESTAMP__=\"redacted\"",
            ])],
        )],
    )

#
# Core Rule Implementation
#

def gcc_cc_toolchain_config_impl(ctx, copts = [], linkopts = []):
    # Generate List of Actions
    action_configs = []
    for action_name in ALL_COMPILE_ACTIONS:
        action_configs.append(action_config(
            action_name = action_name,
            implies = [
                FEATURE_NAMES.default_compile_flags,
                FEATURE_NAMES.user_compile_flags,
                FEATURE_NAMES.sysroot,
                FEATURE_NAMES.unfiltered_compile_flags,
                FEATURE_NAMES.compiler_input_flags,
                FEATURE_NAMES.compiler_output_flags,
            ],
            tools = make_tool(ctx, ctx.file.cctool),
        ))
    for action_name in ALL_LINK_ACTIONS:
        if action_name == ACTION_NAMES.cpp_link_executable:
            implies = [FEATURE_NAMES.force_pic_flags]
        else:
            implies = [FEATURE_NAMES.shared_flag]
        action_configs.append(action_config(
            action_name = action_name,
            implies = implies + [
                FEATURE_NAMES.default_link_flags,
                FEATURE_NAMES.strip_debug_symbols,
                FEATURE_NAMES.linkstamps,
                FEATURE_NAMES.output_execpath_flags,
                FEATURE_NAMES.runtime_library_search_directories,
                FEATURE_NAMES.library_search_directories,
                FEATURE_NAMES.libraries_to_link,
                FEATURE_NAMES.user_link_flags,
                FEATURE_NAMES.linker_param_file,
                FEATURE_NAMES.fission_support,
                FEATURE_NAMES.sysroot,
            ],
            tools = make_tool(ctx, ctx.file.linktool),
        ))
    action_configs.append(action_config(
        action_name = ACTION_NAMES.cpp_link_static_library,
        implies = [
            FEATURE_NAMES.archiver_flags,
            FEATURE_NAMES.linker_param_file,
        ],
        tools = make_tool(ctx, ctx.file.artool),
    ))
    action_configs.append(action_config(
        action_name = ACTION_NAMES.strip,
        flag_sets = gcc_strip_flag_set(ctx),
        tools = make_tool(ctx, ctx.file.strip),
    ))

    # Construct List of Artifacts
    artifact_name_patterns = [
        artifact_name_pattern("alwayslink_static_library", "lib", ".lo"),
        artifact_name_pattern("executable", None, None),
        artifact_name_pattern("included_file_list", None, ".d"),
        artifact_name_pattern("object_file", None, ".o"),
        artifact_name_pattern("static_library", "lib", ".a"),
    ]

    # Support List
    features = [
        feature(name = FEATURE_NAMES.dbg),
        feature(name = FEATURE_NAMES.fastbuild),
        feature(name = FEATURE_NAMES.opt),
        feature(name = FEATURE_NAMES.no_legacy_features),
    ]
    if FEATURE_NAMES.supports_dynamic_linker in ctx.features:
        artifact_name_patterns.extend([
            artifact_name_pattern("dynamic_library", "lib", ".so"),
            artifact_name_pattern("interface_library", "lib", ".ifso"),
        ])
        features.append(feature(
            name = FEATURE_NAMES.supports_dynamic_linker,
            enabled = True,
        ))
    if FEATURE_NAMES.supports_pic in ctx.features:
        artifact_name_patterns.extend([
            artifact_name_pattern("pic_file", None, ".pic"),
            artifact_name_pattern("pic_object_file", None, ".pic.o"),
        ])
        features.append(feature(
            name = FEATURE_NAMES.supports_pic,
            enabled = True,
        ))
    if FEATURE_NAMES.supports_start_end_lib in ctx.features:
        features.append(feature(
            name = FEATURE_NAMES.supports_start_end_lib,
            enabled = True,
        ))

    # Action Groups
    features += [
        # Compiler Flags
        make_default_compile_flags_feature(ctx, copts),
        gcc_dependency_file_feature(ctx),
        gcc_pic_feature(ctx),
        gcc_per_object_debug_info_feature(ctx),
        gcc_preprocessor_defines_feature(ctx),
        gcc_includes_feature(ctx),
        gcc_include_paths_feature(ctx),
        # Linker Flags
        make_default_link_flags_feature(ctx, linkopts),
        gcc_shared_flag_feature(ctx),
        make_linkstamps_feature(ctx),
        gcc_output_execpath_flags_feature(ctx),
        gcc_runtime_library_search_directories_feature(ctx),
        gcc_library_search_directories_feature(ctx),
        gcc_archiver_flags_feature(ctx),
        gcc_libraries_to_link_feature(ctx),
        gcc_force_pic_flags_feature(ctx),
        make_user_link_flags_feature(ctx),
        gcc_static_libgcc_feature(ctx),
        gcc_fission_support(ctx),
        gcc_strip_debug_symbols_feature(ctx),
        gcc_fully_static_link(ctx),
        # Trailing Flags
        make_user_compile_flags_feature(ctx),
        gcc_sysroot_feature(ctx),
        gcc_unfiltered_compile_flags_feature(ctx),
        gcc_linker_param_file_feature(ctx),
        gcc_compiler_input_flags_feature(ctx),
        gcc_compiler_output_flags_feature(ctx),
    ]

    # Additional Parameters
    sysroot = ctx.file.sysroot
    if sysroot:
        sysroot = sysroot.path

    # Construct CcToolchainConfigInfo
    config = cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        abi_libc_version = "local",
        abi_version = "local",
        action_configs = action_configs,
        artifact_name_patterns = artifact_name_patterns,
        builtin_sysroot = sysroot,
        cc_target_os = None,
        compiler = ctx.attr.compiler,
        cxx_builtin_include_directories = ctx.attr.builtin_include_directories,
        features = features,
        host_system_name = "local",
        make_variables = [],
        tool_paths = [],
        target_cpu = ctx.attr.cpu,
        target_libc = "local",
        target_system_name = ctx.attr.target,
        toolchain_identifier = ctx.attr.name,
    )

    # Write out CcToolchainConfigInfo to file (diagnostics)
    pbtxt = ctx.actions.declare_file(ctx.attr.name + ".pbtxt")
    ctx.actions.write(
        output = pbtxt,
        content = config.proto,
    )
    return [DefaultInfo(files = depset([pbtxt])), config]

gcc_cc_toolchain_config = rule(
    attrs = {
        "artool": attr.label(
            allow_single_file = True,
            cfg = "host",
            executable = True,
            mandatory = True,
        ),
        "asmopts": attr.string_list(),
        "builtin_include_directories": attr.string_list(),
        "cctool": attr.label(
            allow_single_file = True,
            cfg = "host",
            executable = True,
            mandatory = True,
        ),
        "compiler": attr.string(default = "gcc"),
        "conlyopts": attr.string_list(
            default = ["-std=c17"],
        ),
        "copts": attr.string_list(),
        "cpu": attr.string(default = "local"),
        "cxxopts": attr.string_list(
            default = ["-std=c++17"],
        ),
        "linkopts": attr.string_list(),
        "linktool": attr.label(
            allow_single_file = True,
            cfg = "host",
            executable = True,
            mandatory = True,
        ),
        "modes": attr.string_list_dict(),
        "objcopy": attr.label(
            allow_single_file = True,
            cfg = "host",
            executable = True,
            mandatory = True,
        ),
        "strip": attr.label(
            allow_single_file = True,
            cfg = "host",
            executable = True,
            mandatory = True,
        ),
        "stripopts": attr.string_list(
            default = ["-S", "-p"],
        ),
        "sysroot": attr.label(
            allow_single_file = True,
            cfg = "host",
        ),
        "target": attr.string(default = "local"),
    },
    implementation = gcc_cc_toolchain_config_impl,
)

def gcc_toolchain(
        name,
        all_files,
        compiler_files,
        target_compatible_with,
        exec_compatible_with = None,
        objcopy_files = None,
        strip_files = None,
        target_files = None,
        visibility = None,
        **kwargs):
    """C/C++ Toolchain Macro for Generic Unix.

    Targets:
        {name}: Instance of `toolchain`.
        {name}-toolchain: Instance of `cc_toolchain`.
    """
    gcc_cc_toolchain_config(
        name = name + "-config",
        tags = ["manual"],
        visibility = ["//visibility:private"],
        **kwargs
    )
    if target_files:
        native.filegroup(
            name = name + "-files",
            srcs = [all_files] + target_files,
            tags = ["manual"],
            visibility = ["//visibility:private"],
        )
        all_files = ":%s-files" % name
        native.filegroup(
            name = name + "-compiler-files",
            srcs = [compiler_files] + target_files,
            tags = ["manual"],
            visibility = ["//visibility:private"],
        )
        compiler_files = ":%s-compiler-files" % name
    cc_toolchain(
        name = name + "-toolchain",
        all_files = all_files,
        ar_files = kwargs["artool"],
        as_files = compiler_files,
        compiler_files = compiler_files,
        dwp_files = compiler_files,
        libc_top = None,
        linker_files = all_files,
        objcopy_files = objcopy_files or kwargs["objcopy"],
        strip_files = strip_files or kwargs["strip"],
        supports_header_parsing = False,
        supports_param_files = False,
        toolchain_config = ":%s-config" % name,
        tags = ["manual"],
        visibility = visibility,
    )
    native.toolchain(
        name = name,
        exec_compatible_with = exec_compatible_with,
        target_compatible_with = target_compatible_with,
        toolchain = ":%s-toolchain" % name,
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        visibility = visibility,
    )
