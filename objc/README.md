# Objective-C rules

Rules for generating Objective-C protobuf and gRPC `.m` & `.h` files and libraries using standard Protocol Buffers and gRPC. Libraries are created with the Bazel native `objc_library`

| Rule | Description |
| ---: | :--- |
| [objc_proto_compile](#objc_proto_compile) | Generates Objective-C protobuf `.m` & `.h` artifacts |
| [objc_grpc_compile](#objc_grpc_compile) | Generates Objective-C protobuf+gRPC `.m` & `.h` artifacts |
| [objc_proto_library](#objc_proto_library) | Generates an Objective-C protobuf library using `objc_library` |

---

## `objc_proto_compile`

Generates Objective-C protobuf `.m` & `.h` artifacts

### `WORKSPACE`

```python
load("@rules_proto_grpc//objc:repositories.bzl", "objc_deps")

objc_deps()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//objc:defs.bzl", "objc_proto_compile")

objc_proto_compile(
    name = "person_objc_proto",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `objc_grpc_compile`

Generates Objective-C protobuf+gRPC `.m` & `.h` artifacts

### `WORKSPACE`

```python
load("@rules_proto_grpc//objc:repositories.bzl", "objc_deps")

objc_deps()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//objc:defs.bzl", "objc_grpc_compile")

objc_grpc_compile(
    name = "greeter_objc_grpc",
    deps = ["@rules_proto_grpc//example/proto:greeter_grpc"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |

---

## `objc_proto_library`

Generates an Objective-C protobuf library using `objc_library`

### `WORKSPACE`

```python
load("@rules_proto_grpc//objc:repositories.bzl", "objc_deps")

objc_deps()
```

### `BUILD.bazel`

```python
load("@rules_proto_grpc//objc:defs.bzl", "objc_proto_library")

objc_proto_library(
    name = "person_objc_library",
    deps = ["@rules_proto_grpc//example/proto:person_proto"],
)
```

### Attributes

| Name | Type | Mandatory | Default | Description |
| ---: | :--- | --------- | ------- | ----------- |
| `deps` | `list<ProtoInfo>` | true | `[]`    | List of labels that provide a `ProtoInfo` (such as `native.proto_library`)          |
| `verbose` | `int` | false | `0`    | The verbosity level. Supported values and results are 1: *show command*, 2: *show command and sandbox after running protoc*, 3: *show command and sandbox before and after running protoc*, 4. *show env, command, expected outputs and sandbox before and after running protoc*          |
