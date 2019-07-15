# Scala rules

Rules for generating Scala protobuf and gRPC `.jar` files and libraries using [ScalaPB](https://github.com/scalapb/ScalaPB). Libraries are created with `scala_library` from [rules_scala](https://github.com/bazelbuild/rules_scala)

| Rule | Description |
| ---: | :--- |
| [scala_proto_compile](#scala_proto_compile) | Generates a Scala protobuf `.jar` artifact |
| [scala_grpc_compile](#scala_grpc_compile) | Generates Scala protobuf+gRPC `.jar` artifacts |
| [scala_proto_library](#scala_proto_library) | Generates a Scala protobuf library using `scala_library` from `rules_scala` |
| [scala_grpc_library](#scala_grpc_library) | Generates a Scala protobuf+gRPC library using `scala_library` from `rules_scala` |

---

## `scala_proto_compile`

Generates a Scala protobuf `.jar` artifact

### `WORKSPACE`

```python
load("@rules_proto_grpc//scala:deps.bzl", "scala_deps")

scala_deps()

# rules_go used here to compile a wrapper around the protoc-gen-scala plugin
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//scala:defs.bzl", "scala_proto_compile")

scala_proto_compile(
    name = "person_scala_proto",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `scala_grpc_compile`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates Scala protobuf+gRPC `.jar` artifacts

### `WORKSPACE`

```python
load("@rules_proto_grpc//scala:deps.bzl", "scala_deps")

scala_deps()

# rules_go used here to compile a wrapper around the protoc-gen-scala plugin
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//scala:defs.bzl", "scala_grpc_compile")

scala_grpc_compile(
    name = "greeter_scala_grpc",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `scala_proto_library`

Generates a Scala protobuf library using `scala_library` from `rules_scala`

### `WORKSPACE`

```python
load("@rules_proto_grpc//scala:deps.bzl", "scala_deps")

scala_deps()

# rules_go used here to compile a wrapper around the protoc-gen-scala plugin
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//scala:defs.bzl", "scala_proto_library")

scala_proto_library(
    name = "person_scala_library",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `scala_grpc_library`

> NOTE: this rule is EXPERIMENTAL.  It may not work correctly or even compile!

Generates a Scala protobuf+gRPC library using `scala_library` from `rules_scala`

### `WORKSPACE`

```python
load("@rules_proto_grpc//scala:deps.bzl", "scala_deps")

scala_deps()

# rules_go used here to compile a wrapper around the protoc-gen-scala plugin
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")

scala_proto_repositories()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//scala:defs.bzl", "scala_grpc_library")

scala_grpc_library(
    name = "greeter_scala_library",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
