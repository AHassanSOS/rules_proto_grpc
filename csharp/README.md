# C# rules

Rules for generating C# protobuf and gRPC `.cs` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with `core_library` from [rules_dotnet](https://github.com/bazelbuild/rules_dotnet)

**NOTE 1**: the csharp_* rules currently don't play nicely with sandboxing.  You may see errors like:

~~~python
The user's home directory could not be determined. Set the 'DOTNET_CLI_HOME' environment variable to specify the directory to use.
~~~

or

~~~python
System.ArgumentNullException: Value cannot be null.
Parameter name: path1
   at System.IO.Path.Combine(String path1, String path2)
   at Microsoft.DotNet.Configurer.CliFallbackFolderPathCalculator.get_DotnetUserProfileFolderPath()
   at Microsoft.DotNet.Configurer.FirstTimeUseNoticeSentinel..ctor(CliFallbackFolderPathCalculator cliFallbackFolderPathCalculator)
   at Microsoft.DotNet.Cli.Program.ProcessArgs(String[] args, ITelemetry telemetryClient)
   at Microsoft.DotNet.Cli.Program.Main(String[] args)
~~~

To remedy this, use --strategy=CoreCompile=standalone for the csharp rules (put it in your .bazelrc file).

**NOTE 2**: the csharp nuget dependency sha256 values do not appear stable.

| Rule | Description |
| ---: | :--- |
| [csharp_proto_compile](#csharp_proto_compile) | Generates C# protobuf `.cs` artifacts |
| [csharp_grpc_compile](#csharp_grpc_compile) | Generates C# protobuf+gRPC `.cs` artifacts |
| [csharp_proto_library](#csharp_proto_library) | Generates a C# protobuf library using `core_library` from `rules_dotnet` |
| [csharp_grpc_library](#csharp_grpc_library) | Generates a C# protobuf+gRPC library using `core_library` from `rules_dotnet` |

---

## `csharp_proto_compile`

Generates C# protobuf `.cs` artifacts

### `WORKSPACE`

```python
load("@rules_proto_grpc//csharp:repositories.bzl", "csharp_deps")

csharp_deps()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_proto_compile")

csharp_proto_compile(
    name = "person_csharp_proto",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `csharp_grpc_compile`

Generates C# protobuf+gRPC `.cs` artifacts

### `WORKSPACE`

```python
load("@rules_proto_grpc//csharp:repositories.bzl", "csharp_deps")

csharp_deps()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_grpc_compile")

csharp_grpc_compile(
    name = "greeter_csharp_grpc",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `csharp_proto_library`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates a C# protobuf library using `core_library` from `rules_dotnet`

### `WORKSPACE`

```python
load("@rules_proto_grpc//csharp:repositories.bzl", "csharp_deps")

csharp_deps()

load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_register_sdk",
    "dotnet_register_toolchains",
    "dotnet_repositories",
)

core_version = "v2.1.503"

dotnet_register_toolchains(
    core_version = core_version,
)

dotnet_register_toolchains(
    core_version = core_version,
)

core_register_sdk(
    name = "core_sdk",
    core_version = core_version,
)

dotnet_repositories()

load("@rules_proto_grpc//csharp/nuget:packages.bzl", nuget_packages = "packages")

nuget_packages()

load("@rules_proto_grpc//csharp/nuget:nuget.bzl", "nuget_protobuf_packages")

nuget_protobuf_packages()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_proto_library")

csharp_proto_library(
    name = "person_csharp_library",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### `Flags`

| Category | Flag | Value | Description |
| --- | --- | --- | --- |
| build | strategy | CoreCompile=standalone | dotnet SDK desperately wants to find the HOME directory |

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `csharp_grpc_library`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates a C# protobuf+gRPC library using `core_library` from `rules_dotnet`

### `WORKSPACE`

```python
load("@rules_proto_grpc//csharp:repositories.bzl", "csharp_deps")

csharp_deps()

load(
    "@io_bazel_rules_dotnet//dotnet:defs.bzl",
    "core_register_sdk",
    "dotnet_register_toolchains",
    "dotnet_repositories",
)

core_version = "v2.1.503"

dotnet_register_toolchains(
    core_version = core_version,
)

dotnet_register_toolchains(
    core_version = core_version,
)

core_register_sdk(
    name = "core_sdk",
    core_version = core_version,
)

dotnet_repositories()

load("@rules_proto_grpc//csharp/nuget:packages.bzl", nuget_packages = "packages")

nuget_packages()

load("@rules_proto_grpc//csharp/nuget:nuget.bzl", "nuget_protobuf_packages")

nuget_protobuf_packages()

load("@rules_proto_grpc//csharp/nuget:nuget.bzl", "nuget_grpc_packages")

nuget_grpc_packages()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//csharp:defs.bzl", "csharp_grpc_library")

csharp_grpc_library(
    name = "greeter_csharp_library",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### `Flags`

| Category | Flag | Value | Description |
| --- | --- | --- | --- |
| build | strategy | CoreCompile=standalone | dotnet SDK desperately wants to find the HOME directory |

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
