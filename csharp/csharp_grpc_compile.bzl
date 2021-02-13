load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load("//:plugin.bzl", "ProtoPluginInfo")
load(
    "//:aspect.bzl",
    "ProtoLibraryAspectNodeInfo",
    "proto_compile_aspect_attrs",
    "proto_compile_aspect_impl",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create aspect for csharp_grpc_compile
csharp_grpc_compile_aspect = aspect(
    implementation = proto_compile_aspect_impl,
    provides = [ProtoLibraryAspectNodeInfo],
    attr_aspects = ["deps"],
    attrs = dict(
        proto_compile_aspect_attrs,
        _plugins = attr.label_list(
            doc = "List of protoc plugins to apply",
            providers = [ProtoPluginInfo],
            default = [
                Label("//csharp:csharp_plugin"),
                Label("//csharp:grpc_csharp_plugin"),
            ],
        ),
        _prefix = attr.string(
            doc = "String used to disambiguate aspects when generating outputs",
            default = "csharp_grpc_compile_aspect",
        ),
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)

# Create compile rule to apply aspect
_rule = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        protos = attr.label_list(
            mandatory = False,  # TODO: set to true in 4.0.0 when deps removed below
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [csharp_grpc_compile_aspect],
            doc = "List of labels that provide a ProtoInfo (such as rules_proto proto_library)",
        ),
        deps = attr.label_list(
            mandatory = False,
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [csharp_grpc_compile_aspect],
            doc = "DEPRECATED: Use protos attr"
        ),
    ),
)

# Create macro for converting attrs and passing to compile
def csharp_grpc_compile(**kwargs):
    _rule(
        verbose_string = "{}".format(kwargs.get("verbose", 0)),
        merge_directories = True,
        **{k: v for k, v in kwargs.items() if k != "merge_directories"}
    )
