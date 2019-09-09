GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOINSTALL=$(GOCMD) install
BUILDDIR=$(PWD)/.bin

all: prep build test hv_darwin hv_linux hv_windows
.PHONY: prep
prep:
	mkdir -p $(BUILDDIR)
.PHONY: build
build:
	export GO111MODULE=on
	$(GOBUILD) -v ./... 
.PHONY: test
test: 
	export GO111MODULE=on
	$(GOTEST) -v ./...
.PHONY: hv_darwin
hv_darwin:
	export GO111MODULE=on
	export GOOS=darwin
	export GOARCH=arm64
	$(GOBUILD) -o $(BUILDDIR)/hashicorp_verifier_darwin_amd64 ./cmd/hashicorp_verifier
.PHONY: hv_linux
hv_linux:
	export GO111MODULE=on
	export GOOS=linux 
	export GOARCH=arm64 
	$(GOBUILD) -o $(BUILDDIR)/hashicorp_verifier_linux_amd64 ./cmd/hashicorp_verifier
.PHONY: hv_windows
hv_windows:
	export GO111MODULE=on
	export GOOS=windows 
	export GOARCH=arm64 
	$(GOBUILD) -o $(BUILDDIR)/hashicorp_verifier_windows_amd64.exe ./cmd/hashicorp_verifier
