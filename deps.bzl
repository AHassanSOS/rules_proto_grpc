load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//:utils.bzl", "github_archive", "get_ref", "get_sha256")

def external_zlib(**kwargs):
    if "zlib" not in native.existing_rules():
        http_archive(
            name = "zlib",
            build_file = "@com_google_protobuf//:third_party/zlib.BUILD",
            sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
            strip_prefix = "zlib-1.2.11",
            urls = ["https://zlib.net/zlib-1.2.11.tar.gz"],
        )

def com_github_bazelbuild_buildtools(**kwargs):
    if "com_github_bazelbuild_buildtools" not in native.existing_rules():
        name = "com_github_bazelbuild_buildtools"
        ref = get_ref(name, "6415663945d3248207da955aafa1fa2af1a0f2ed", kwargs)
        sha256 = get_sha256(name, "d1e28237d1f4c2255c504246b4f3fd36f74d590f2974491b4399a84c58b495ed", kwargs)
        github_archive(name, "bazelbuild", "buildtools", ref, sha256)

def com_google_protobuf(**kwargs):
    if "com_google_protobuf" not in native.existing_rules():
        name = "com_google_protobuf"
        ref = get_ref(name, "2d0fdcb791dd59599cce812841149ff779b7c371", kwargs) # 3.9.0 rc1 + PR 6310
        sha256 = get_sha256(name, "a6d34f9f32421425f6e2971de121356cf61efa576100dd37762b83869f05b17a", kwargs)
        github_archive(name, "protocolbuffers", "protobuf", ref, sha256)

    if "protobuf_clib" not in native.existing_rules():
        native.bind(
            name = "protobuf_clib",
            actual = "@com_google_protobuf//:protoc_lib",
        )

    if "protobuf_headers" not in native.existing_rules():
        native.bind(
            name = "protobuf_headers",
            actual = "@com_google_protobuf//:protobuf_headers",
        )

def com_github_grpc_grpc(**kwargs):
    if "com_github_grpc_grpc" not in native.existing_rules():
        name = "com_github_grpc_grpc"
        ref = get_ref(name, "v1.21.0", kwargs)
        sha256 = get_sha256(name, "8da7f32cc8978010d2060d740362748441b81a34e5425e108596d3fcd63a97f2", kwargs)
        github_archive(name, "grpc", "grpc", ref, sha256)

def io_bazel_rules_dotnet(**kwargs):
    if "io_bazel_rules_dotnet" not in native.existing_rules():
        name = "io_bazel_rules_dotnet"
        ref = get_ref(name, "e9537b4a545528b11b270dfa124f3193bdb2d78e", kwargs)  # June 26, 2019
        sha256 = get_sha256(name, "9ee5429417190f00b2c970ba628db833e7ce71323efb646b9ce6b3aaaf56f125", kwargs)
        github_archive(name, "bazelbuild", "rules_dotnet", ref, sha256)

def io_bazel_rules_scala(**kwargs):
    if "io_bazel_rules_scala" not in native.existing_rules():
        name = "io_bazel_rules_scala"
        ref = get_ref(name, "14d9742496859faaf860b1adfc8126f3ed077921", kwargs)  # May 3, 2019
        sha256 = get_sha256(name, "72fc4357b29ec93951d472ee22a4cc3f30e170234a4ec73ff678f43f7e276bd4", kwargs)
        github_archive(name, "bazelbuild", "rules_scala", ref, sha256)

def io_bazel_rules_rust(**kwargs):
    if "io_bazel_rules_rust" not in native.existing_rules():
        name = "io_bazel_rules_rust"
        ref = get_ref(name, "3fac9fe0001d2a829d8ddaf3033b5171c049abdb", kwargs)  # 2019-07-02
        sha256 = get_sha256(name, "299108772020c103eefacb4de30873d45224e8e0e6c11df7b56ffd11d959e212", kwargs)
        github_archive(name, "bazelbuild", "rules_rust", ref, sha256)

def com_github_yugui_rules_ruby(**kwargs):
    if "com_github_yugui_rules_ruby" not in native.existing_rules():
        name = "com_github_yugui_rules_ruby"
        ref = get_ref(name, "73479cdc6a34a8d940cc3c904badf7a2ae6bdc6d", kwargs)  # PR#8,
        sha256 = get_sha256(name, "bd88b1aa144f70bb3f069ff3ddc5ddba032311ce27fb40b7276db694dcb63490", kwargs)
        github_archive(name, "yugui", "rules_ruby", ref, sha256)

def grpc_ecosystem_grpc_gateway(**kwargs):
    if "grpc_ecosystem_grpc_gateway" not in native.existing_rules():
        name = "grpc_ecosystem_grpc_gateway"
        ref = get_ref(name, "79ff520b46091f8148bafeafd6e798826d6d47c2", kwargs)  # Apr 2019
        sha256 = get_sha256(name, "a8d283391d1e37b2bea798082f198187dd1edfed03da00f5be96edc6dadfde44", kwargs)
        github_archive(name, "grpc-ecosystem", "grpc-gateway", ref, sha256)

def build_bazel_rules_android(**kwargs):
    if "build_bazel_rules_android" not in native.existing_rules():
        name = "build_bazel_rules_android"
        ref = get_ref(name, "9ab1134546364c6de84fc6c80b4202fdbebbbb35", kwargs)  # 2019-06-19
        sha256 = get_sha256(name, "f329928c62ade05ceda72c4e145fd300722e6e592627d43580dd0a8211c14612", kwargs)
        github_archive(name, "bazelbuild", "rules_android", ref, sha256)

def build_bazel_rules_swift(**kwargs):
    if "build_bazel_rules_swift" not in native.existing_rules():
        name = "build_bazel_rules_swift"
        ref = get_ref(name, "c935de3d04a8d24feb09a57df3b33a328be5d863", kwargs)  # 0.11.1
        sha256 = get_sha256(name, "797593aef1401c3fedfe0762ec073bfe7619ab8e4e26558614a1daa491e501a4", kwargs)
        github_archive(name, "bazelbuild", "rules_swift", ref, sha256)

def com_github_apple_swift_swift_protobuf(**kwargs):
    if "com_github_apple_swift_swift_protobuf" not in native.existing_rules():
        version = "1.4.0"
        http_archive(
            name = "com_github_apple_swift_swift_protobuf",
            url = "https://github.com/apple/swift-protobuf/archive/%s.tar.gz" % version,
            sha256 = "efa256d572d19fc23756a30089129af523173ad29a84ee87800fa88f056efaac",
            strip_prefix = "swift-protobuf-" + version,
            build_file = "@build_bazel_rules_swift//third_party:com_github_apple_swift_swift_protobuf/BUILD.overlay",
        )

def io_bazel_rules_go(**kwargs):
    if "io_bazel_rules_go" not in native.existing_rules():
        name = "io_bazel_rules_go"
        ref = get_ref(name, "6fc21c78143ff1d4ea98100e8fd7a928d45abd00", kwargs)  # 0.18.6
        sha256 = get_sha256(name, "d9f58122d7cece7c73ddd4408e90ba0ac48bf45b58de74550cc446319ad61617", kwargs)
        github_archive(name, "bazelbuild", "rules_go", ref, sha256)

def com_apt_itude_rules_pip(**kwargs):
    if "com_apt_itude_rules_pip" not in native.existing_rules():
        name = "com_apt_itude_rules_pip"
        ref = get_ref(name, "ce667087818553cdc4b1a2258fc53df917c4f87c", kwargs)  # 2019-07-07
        sha256 = get_sha256(name, "5cabd6bfb9cef095d0d076faf5e7acd5698f7172e803059c21c4e700a07b131b", kwargs)
        github_archive(name, "apt-itude", "rules_pip", ref, sha256)

def six(**kwargs):
    name = "six"
    if name not in native.existing_rules():
        http_archive(
            name = name,
            build_file_content = """
genrule(
  name = "copy_six",
  srcs = ["six.py"],
  outs = ["__init__.py"],
  cmd = "cp $< $(@)",
)
py_library(
  name = "six",
  srcs = ["__init__.py"],
  srcs_version = "PY2AND3",
  visibility = ["//visibility:public"],
)
""",
            sha256 = "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73",
            urls = ["https://pypi.python.org/packages/source/s/six/six-1.12.0.tar.gz"],
            strip_prefix = "six-1.12.0",
        )

def io_bazel_rules_dart(**kwargs):
    if "io_bazel_rules_dart" not in native.existing_rules():
        name = "io_bazel_rules_dart"
        ref = get_ref(name, "07aa5a42827f74d707ad3abcd3edbc14c7cad837", kwargs)  # Mar 11 (fork of dart-lang/rules_dart)
        sha256 = get_sha256(name, "836aa1908fda2c5f25f5a8dc298399d60252006c2953d170b95a33bfc5b5de14", kwargs)
        github_archive(name, "FKint", "rules_dart", ref, sha256)

def io_bazel_rules_d(**kwargs):
    if "io_bazel_rules_d" not in native.existing_rules():
        name = "io_bazel_rules_d"
        ref = get_ref(name, "c4af62269c85dd5dcab0be119196baa5da4662b6", kwargs) # June 28, 2019 + PR 30
        sha256 = get_sha256(name, "ef380076035d42bfc8b9a5547092779792de4b0cf718b9623a7c1923b0cd23e6", kwargs)
        github_archive(name, "bazelbuild", "rules_d", ref, sha256)

def rules_jvm_external(**kwargs):
    if "rules_jvm_external" not in native.existing_rules():
        name = "rules_jvm_external"
        ref = get_ref(name, "e359007344bc53133e1e54c891670d08453d4827", kwargs)  # May 7 2019
        sha256 = get_sha256(name, "150c8cd5a3abe8b2da09235ebe5aedd0a379440d9f6a15d1c99c2b1e560a09f9", kwargs)
        github_archive(name, "bazelbuild", "rules_jvm_external", ref, sha256)

def io_grpc_grpc_java(**kwargs):
    if "io_grpc_grpc_java" not in native.existing_rules():
        name = "io_grpc_grpc_java"
        ref = get_ref(name, "46ef51576f7128874feba8067e13fc7b7e131f6f", kwargs) # v1.21.0 + plugin fix
        sha256 = get_sha256(name, "c86c32a06a3db8d88839c682dc18e5acee130e29e4c009d64826fb580729fd91", kwargs)
        github_archive(name, "grpc", "grpc-java", ref, sha256)


def com_github_scalapb_scalapb(**kwargs):
    if "com_github_scalapb_scalapb" not in native.existing_rules():
        http_archive(
            name = "com_github_scalapb_scalapb",
            url = "https://github.com/scalapb/ScalaPB/releases/download/v0.8.0/scalapbc-0.8.0.zip",
            sha256 = "bda0b44b50f0a816342a52c34e6a341b1a792f2a6d26f4f060852f8f10f5d854",
            strip_prefix = "scalapbc-0.8.0/lib",
            build_file_content = """
java_import(
    name = "compilerplugin",
    jars = ["com.thesamet.scalapb.compilerplugin-0.8.0.jar"],
    visibility = ["//visibility:public"],
)
java_import(
    name = "scala-library",
    jars = ["org.scala-lang.scala-library-2.11.12.jar"],
    visibility = ["//visibility:public"],
)
            """,
        )

def com_github_stackb_grpc_js(**kwargs):
    if "com_github_stackb_grpc_js" not in native.existing_rules():
        name = "com_github_stackb_grpc_js"
        ref = get_ref(name, "d075960a9e62846ce92ae1029a777c141809f489", kwargs)
        sha256 = get_sha256(name, "c0f422823486986ea965fd36a0f5d3380151516421a6de8b69b72778cf3798a4", kwargs)
        github_archive(name, "stackb", "grpc.js", ref, sha256)

def bazel_gazelle(**kwargs):
    if "bazel_gazelle" not in native.existing_rules():
        name = "bazel_gazelle"
        ref = get_ref(name, "63ddd72aa315d020456f1a96bc6fcca9405810cb", kwargs)
        sha256 = get_sha256(name, "bff502b74b6ad77d0b9b558ebe99b030d6ba9ab0e3a8b4cb396448bf7fe88ab4", kwargs)
        github_archive(name, "bazelbuild", "bazel-gazelle", ref, sha256)

def bazel_skylib(**kwargs):
    if "bazel_skylib" not in native.existing_rules():
        name = "bazel_skylib"
        ref = get_ref(name, "be3b1fc838386bdbea39d9750ea4411294870575", kwargs)  # Apr 13, 2019
        sha256 = get_sha256(name, "6128dd2af9830430e0ae404cb6fdce754fb80ed88942e1a0865a7f376bb68c4e", kwargs)
        github_archive(name, "bazelbuild", "bazel-skylib", ref, sha256)

def com_github_grpc_grpc_web(**kwargs):
    if "com_github_grpc_grpc_web" not in native.existing_rules():
        name = "com_github_grpc_grpc_web"
        ref = get_ref(name, "ffe8e9c9036f4ec7d5b55da75b1758b1f57fbf8d", kwargs)
        sha256 = get_sha256(name, "936ca06fe7a9b55c1e334e4869e1d153fec68d92d750d2b550e41e1c5580b4dd", kwargs)
        github_archive(name, "grpc", "grpc-web", ref, sha256)

def io_bazel_rules_closure(**kwargs):
    if "io_bazel_rules_closure" not in native.existing_rules():
        name = "io_bazel_rules_closure"
        ref = get_ref(name, "03110588392d8c6c05b99c08a6f1c2121604ca27", kwargs)
        sha256 = get_sha256(name, "12d17f241fc73f562825b0bba11a21040580d82da00be4689f5942c05508d8da", kwargs)
        github_archive(name, "bazelbuild", "rules_closure", ref, sha256)

def build_bazel_rules_nodejs(**kwargs):
    if "build_bazel_rules_nodejs" not in native.existing_rules():
        name = "build_bazel_rules_nodejs"
        ref = get_ref(name, "fb1133d1259992c196df31e2da6540fa6d54f191", kwargs) # 0.32.2
        sha256 = get_sha256(name, "4e91b794f01cc8b1c690ae4d7ae8815ac6a4d4e9d2a5ac5988233ad0be564355", kwargs)
        github_archive(name, "bazelbuild", "rules_nodejs", ref, sha256)
