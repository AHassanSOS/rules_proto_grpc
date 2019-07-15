# Protobuf and gRPC rules for [Bazel](https://bazel.build)

Bazel rules for building Protocol Buffers and gRPC :rocket:

[![Build Status](https://badge.buildkite.com/5980cc1d55f96e721bd9a7bd5dc1e40a096a7c30bc13117910.svg?branch=master)](https://buildkite.com/bazel/rules-proto)


## Contents:

- [Overview](#overview)
- [Installation](#installation)
- [Rules](#rules)
    - [Android](/android/README.md)
    - [Closure](/closure/README.md)
    - [C++](/cpp/README.md)
    - [C#](/csharp/README.md)
    - [D](/d/README.md)
    - [Go](/go/README.md)
    - [Go (gogoprotobuf)](/github.com/gogo/protobuf/README.md)
    - [grpc-gateway](/github.com/grpc-ecosystem/grpc-gateway/README.md)
    - [gRPC-Web](/github.com/grpc/grpc-web/README.md)
    - [grpc.js](/github.com/stackb/grpc.js/README.md)
    - [Java](/java/README.md)
    - [Node.js](/nodejs/README.md)
    - [Objective-C](/objc/README.md)
    - [PHP](/php/README.md)
    - [Python](/python/README.md)
    - [Ruby](/ruby/README.md)
    - [Rust](/rust/README.md)
    - [Scala](/scala/README.md)
    - [Swift](/swift/README.md)
- [Example Usage](#example-usage)
- [Developers](#developers)
    - [Code Layout](#code-layout)
    - [Rule Generation](#rule-generation)
    - [How-it-works](#how-it-works)
    - [Developing Custom Plugins](#developing-custom-plugins)
- [Contributing](#contributing)


## Overview

These rules provide [Protocol Buffers (Protobuf)](https://developers.google.com/protocol-buffers/)
and [gRPC](https://grpc.io/) rules for a range of languages and services.

Each supported language (`{lang}` below) is generally split into four rule
flavours:

- `{lang}_proto_compile`: Provides generated files from the Protobuf `protoc`
  plugin for the language. e.g for C++ this provides the generated `*.pb.cc`
  and `*.pb.h` files.

- `{lang}_proto_library`: Provides a language-specific library from the
  generated Protobuf `protoc` plugin outputs, along with necessary
  dependencies. e.g for C++ this provides a Bazel native `cpp_library` created
  from the generated `*.pb.cc` and `*pb.h` files, with the Protobuf library
  linked. For languages that do not have a 'library' concept, this rule may not
  exist.

- `{lang}_grpc_compile`: Provides generated files from both the Protobuf and
  gRPC `protoc` plugins for the language. e.g for C++ this provides the
  generated `*.pb.cc`, `*.grpc.pb.cc`, `*.pb.h` and `*.grpc.pb.h` files.

- `{lang}_proto_library`: Provides a language-specific library from the
  generated Protobuf and gRPC `protoc` plugins outputs, along with necessary
  dependencies. e.g for C++ this provides a Bazel native `cpp_library` created
  from the generated `*.pb.cc`, `*.grpc.pb.cc`, `*.pb.h` and `*.grpc.pb.h`
  files, with the Protobuf and gRPC libraries linked. For languages that do not
  have a 'library' concept, this rule may not exist.

Therefore, if you are solely interested in the generated source code artifacts,
use the `{lang}_{proto|grpc}_compile` rules. Otherwise, if you want a
ready-to-go library, use the `{lang}_{proto|grpc}_library` rules.

These rules are derived from the excellent [stackb/rules_proto](https://github.com/stackb/rules_proto)
and add aspect-based compilation to all languages, allowing for all
`proto_library` options to be expressed in user code.


## Installation

Add `rules_proto` your `WORKSPACE` file:

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_proto_grpc",
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/{{ .Ref }}.tar.gz"],
    sha256 = "{{ .Sha256 }}",
    strip_prefix = "rules_proto_grpc-{{ .Ref }}",
)
```

**Important**: Follow instructions in the language-specific `README.md` for
additional workspace dependencies that may be required.
