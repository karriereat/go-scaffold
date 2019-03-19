PROJECT := go-scaffold
BINDIR  := $(CURDIR)/bin
VERSION := $(shell cat VERSION)
XC_OS 	:= linux darwin
XC_ARCH := 386 amd64 arm
SOURCE_FILES ?=./...
TEST_PATTERN ?=.
TEST_OPTIONS ?=-v
LINT_VERSION := 1.15.0

export XC_OS
export XC_ARCH
export VERSION
export GO111MODULE := on
export LINT_VERSION
export SOURCE_FILES
export TEST_PATTERN
export TEST_OPTIONS

.PHONY: all
all: help


.PHONY: help
help:
	@echo "make test - run go test"
	@echo "make build - build $(PROJECT) for follwing OS-ARCH constilations: $(XC_OS) / $(XC_ARCH) "
	@echo "make build-dev - build $(PROJECT) for OS-ARCH set by GOOS and GOARCH env variables"
	@echo "make dist - build and create packages with hashsums"
	@echo "make fmt - use gofmt & goimports"
	@echo "make lint - run golangci-lint"


.PHONY: build
build:
	@scripts/build.sh

.PHONY: build-dev
build-dev:
	@scripts/build.sh dev

.PHONY: dist
dist: 
	@scripts/dist.sh

.PHONY: fmt
fmt:
	@scripts/fmt.sh

.PHONY: lint
lint:
	@scripts/lint.sh

.PHONY: test
test:
	@scripts/test.sh

.PHONY: coverage
coverage:
	@scripts/test.sh coverage
	
.PHONY: setup
setup:
	@scripts/add-pre-commit.sh