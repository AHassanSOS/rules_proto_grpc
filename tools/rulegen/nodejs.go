package main

var nodeGrpcCompileWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos="{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()`)

var nodeProtoLibraryWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos="{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@build_bazel_rules_nodejs//:defs.bzl", "yarn_install")

yarn_install(
    name = "nodejs_modules",
    package_json = "@rules_proto_grpc//nodejs:requirements/package.json",
    yarn_lock = "@rules_proto_grpc//nodejs:requirements/yarn.lock",
)`)

var nodeGrpcLibraryWorkspaceTemplate = mustTemplate(`load("@rules_proto_grpc//{{ .Lang.Dir }}:repositories.bzl", rules_proto_grpc_{{ .Lang.Name }}_repos="{{ .Lang.Name }}_repos")

rules_proto_grpc_{{ .Lang.Name }}_repos()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

load("@build_bazel_rules_nodejs//:defs.bzl", "yarn_install")

yarn_install(
    name = "nodejs_modules",
    package_json = "@rules_proto_grpc//nodejs:requirements/package.json",
    yarn_lock = "@rules_proto_grpc//nodejs:requirements/yarn.lock",
)`)

var nodeLibraryRuleTemplateString = `load("//{{ .Lang.Dir }}:{{ .Lang.Name }}_{{ .Rule.Kind }}_compile.bzl", "{{ .Lang.Name }}_{{ .Rule.Kind }}_compile")
load("@build_bazel_rules_nodejs//:defs.bzl", "npm_package")

def {{ .Rule.Name }}(**kwargs):
    # Compile protos
    name_pb = kwargs.get("name") + "_pb"
    {{ .Lang.Name }}_{{ .Rule.Kind }}_compile(
        name = name_pb,
        **{k: v for (k, v) in kwargs.items() if k in ("deps", "verbose")} # Forward args
    )
`

var nodeProtoLibraryRuleTemplate = mustTemplate(nodeLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    npm_package(
        name = kwargs.get("name"),
        deps = [name_pb],
        packages = PROTO_DEPS,
        visibility = kwargs.get("visibility"),
    )

PROTO_DEPS = [
    "@nodejs_modules//google-protobuf",
]`)

var nodeGrpcLibraryRuleTemplate = mustTemplate(nodeLibraryRuleTemplateString + `
    # Create {{ .Lang.Name }} library
    npm_package(
        name = kwargs.get("name"),
        deps = [name_pb],
        packages = GRPC_DEPS,
        visibility = kwargs.get("visibility"),
    )

GRPC_DEPS = [
    "@nodejs_modules//google-protobuf",
    "@nodejs_modules//grpc",
]`)

func makeNode() *Language {
	return &Language{
		Dir:   "nodejs",
		Name:  "nodejs",
		DisplayName: "Node.js",
		Notes: mustTemplate("Rules for generating Node.js protobuf and gRPC `.js` files using standard Protocol Buffers and gRPC."),
		Flags: commonLangFlags,
		SkipTestPlatforms: []string{"all"},
		Rules: []*Rule{
			&Rule{
				Name:             "nodejs_proto_compile",
				Kind:             "proto",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//nodejs:js"},
				WorkspaceExample: protoWorkspaceTemplate,
				BuildExample:     protoCompileExampleTemplate,
				Doc:              "Generates Node.js protobuf `.js` artifacts",
				Attrs:            aspectProtoCompileAttrs,
				SkipTestPlatforms: []string{"none"},
			},
			&Rule{
				Name:             "nodejs_grpc_compile",
				Kind:             "grpc",
				Implementation:   aspectRuleTemplate,
				Plugins:          []string{"//nodejs:js", "//nodejs:grpc_js"},
				WorkspaceExample: nodeGrpcCompileWorkspaceTemplate,
				BuildExample:     grpcCompileExampleTemplate,
				Doc:              "Generates Node.js protobuf+gRPC `.js` artifacts",
				Attrs:            aspectProtoCompileAttrs,
				SkipTestPlatforms: []string{"none"},
			},
// 			&Rule{
// 				Name:             "nodejs_proto_library",
// 				Kind:             "proto",
// 				Implementation:   nodeProtoLibraryRuleTemplate,
// 				WorkspaceExample: nodeProtoLibraryWorkspaceTemplate,
// 				BuildExample:     protoLibraryExampleTemplate,
// 				Doc:              "Generates a Node.js protobuf library",
// 				Attrs:            aspectProtoCompileAttrs,
// 				SkipTestPlatforms: []string{},
// 			},
// 			&Rule{
// 				Name:             "nodejs_grpc_library",
// 				Kind:             "grpc",
// 				Implementation:   nodeGrpcLibraryRuleTemplate,
// 				WorkspaceExample: nodeGrpcLibraryWorkspaceTemplate,
// 				BuildExample:     grpcLibraryExampleTemplate,
// 				Doc:              "Generates a Node.js protobuf+gRPC library",
// 				Attrs:            aspectProtoCompileAttrs,
// 				SkipTestPlatforms: []string{},
// 			},
		},
	}
}
