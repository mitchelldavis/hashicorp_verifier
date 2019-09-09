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
	$(GOBUILD) -v ./... 
.PHONY: test
test: 
	$(GOTEST) -v ./...
.PHONY: hv_darwin
hv_darwin:
	export GOOS=darwin
	export GOARCH=arm64
	$(GOBUILD) -o $(BUILDDIR)/hashicorp_verifier_darwin_amd64 ./cmd/hashicorp_verifier
.PHONY: hv_linux
hv_linux:
	export GOOS=linux 
	export GOARCH=arm64 
	$(GOBUILD) -o $(BUILDDIR)/hashicorp_verifier_linux_amd64 ./cmd/hashicorp_verifier
.PHONY: hv_windows
hv_windows:
	export GOOS=windows 
	export GOARCH=arm64 
	$(GOBUILD) -o $(BUILDDIR)/hashicorp_verifier_windows_amd64.exe ./cmd/hashicorp_verifier
