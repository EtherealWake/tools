# Ethereal Wake Build Tools

**Workspace:** `@com_etherealwake_tools`

Provides infrastructure for building software with Bazel, with specific focus
on cross-compiling and embedded systems.

## Basic Usage

```python
# Load Dependencies
load("@com_etherealwake_tools//:workspace.bzl", "tools_dependencies")
tools_dependencies()

# Register Toolchains for Single-Platform Builds (Host and Target match).
# NOTE: Builds are non-hermetic as they consume system headers and libraries.
load("@com_etherealwake_tools//:workspace.bzl", "tools_register_native_toolchains")
tools_register_native_toolchains()

# Register Toolchains for Cross-Compiling (Host and Target are different)
# NOTE: Builds are hermetic and have broad compatibility, but stale features.
load("@com_etherealwake_tools//:workspace.bzl", "tools_register_cross_toolchains")
tools_register_cross_toolchains()
```

## Platforms and Constraints

**Conditions:**  `@com_etherealwake_tools//conditions`<br>
**Constraints:** `@com_etherealwake_tools//constraints`<br>
**Platforms:**   `@com_etherealwake_tools//platforms`

Individual `constraint_setting` and its `constraint_value` are placed in a
package sharing the `name` of the setting under `//constraints`.
For constraints with very extremely large value spaces
(e.g. `//constraints/arch`) are generally organized into sub-packages.
Aliases to the built-in constraints are provided under `//constraints/cpu`,
`//constraints/os`, and `//constraints/cc/compiler`.

Every `constraint_value` has a matching `config_setting` under `//conditions`
with the same package organization structure.
