package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_library(
	name = "go_default_library",
	srcs = glob(["*.go"]),
	importpath = "github.com/mitchelldavis/hashicorp_verifier",
	deps = [
		"@org_golang_x_crypto//openpgp:go_default_library",
		"@org_golang_x_crypto//openpgp/armor:go_default_library",
		"@org_golang_x_crypto//openpgp/packet:go_default_library",
	],
)

go_binary(
	name = "hashicorp_verifier_linux_amd64",
	embed = [":go_default_library"],
	goos = "linux",
	goarch = "amd64",
	pure = "on"
)

go_binary(
	name = "hashicorp_verifier_darwin_amd64",
	embed = [":go_default_library"],
	goos = "darwin",
	goarch = "amd64",
	pure = "on"
)

go_binary(
	name = "hashicorp_verifier_windows_amd64",
	embed = [":go_default_library"],
	goos = "windows",
	goarch = "amd64",
	pure = "on"
)
