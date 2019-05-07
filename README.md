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

## C++ Toolchain

**Package:** `@com_etherealwake_tools//cc`

The package `@com_etherealwake_tools//cc` is configured to permit
`@com_etherealwake_tools` to serve as a drop-in substitution for `@rules_cc`.
In addition, it provides rules for defining toolchains based on downloaded
copies of clang, gcc, and sysroots for cross-compilation.  Examples of these
toolchains can be found in `@com_etherealwake_tools//tools/cpp`.

### ARM Embedded Toolchain

```python
load("@com_etherealwake_tools//cc:toolchain.bzl", "arm_toolchain")
```

Constructs a toolchain using an official release of the GNU Arm Embedded
Toolchain downloaded directly from
[arm.com](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads).
Intended for Cortex-M and Cortex-R processors, this can be used to generate
code for any ARM processor on a baremetal platform.  An example targeting the
Cortex-M4F processor can be found in `//tools/embedded:cortex-m4f`.

### Clang Toolchain

```python
load("@com_etherealwake_tools//cc:toolchain.bzl", "clang_toolchain")
```

Constructs a toolchain using an official release of LLVM downloaded directly
from [llvm.org](http://releases.llvm.org/).  Can be used to build binaries for
the host system or serve as a cross-compiler when paired with a suitable
sysroot.  Examples of both can be found in `//tools/cpp`.

**TODO:** Currently biased towards Unix-like systems (FreeBSD, Linux, etc.).
Does not function properly with Darwin or MingW.

### GCC-Compatible Toolchain

```python
load("@com_etherealwake_tools//cc:toolchain.bzl", "gcc_toolchain")
```

Can construct a complete C++ toolchain based on a copy of GCC (or compatible
toolchain) automatically downloaded from an online source.  Not useful by
itself, it is used to construct the ARM and Clang toolchains.

**TODO:** Currently biased towards Unix-like systems (FreeBSD, Linux, etc.).
Does not function properly with Darwin or MingW.
