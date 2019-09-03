# Go-Scaffold

[![Build Status](https://img.shields.io/travis/karriereat/go-scaffold.svg?style=flat-square)](https://travis-ci.org/karriereat/go-scaffold)
[![Go Report Card](https://goreportcard.com/badge/github.com/karriereat/go-scaffold?style=flat-square)](https://goreportcard.com/report/github.com/karriereat/go-scaffold)
[![license](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg?style=flat-square)](https://github.com/karriereat/go-scaffold/blob/master/LICENSE)

Scaffolding project for karriere.at GO apps

## Installation
Be sure to replace all occurences of go-scaffold in:
- Readme
- Makefile
- Dockerfile
- go.mod

Update `VERSION` and `CHANGELOG.md` to match your settings
Change the `LICENSE` file or at least update the copyright information in its

## Makefile commands
- `make build` - build {PROJECT} with in makefile defined OS-ARCH constellations
- `make build-dev` - build {PROJECT} for OS-ARCH set by GOOS and GOARCH env variables
- `make build-docker` - build {PROJECT} for linux-amd64 docker image
- `make fmt` - use gofmt & goimports
- `make lint` - run `golangci-lint`
- `make test` - run go test including race detection
- `make coverage` - same as `make test` and using `go-junit-report` for report.xml
- `make dist` - build and create packages with hashsums
- `make docker` - creates a docker image
- `make docker-release/docker-release-latest` - creates the docker image and pushes it to the registry (latest pushes also latest tag) - not fully implemented
- `make setup` - adds git pre-commit hooks

## Makefile variables
- `PROJECT` - name of the project which is been used for naming etc.
- `VERSION` - reads content of the `VERSION` file
- `XC_OS` - list of operating systems for cross compiling. Default: `linux darwin`
- `XC_ARCH` - list of architectures for cross compiling. Default: `386 amd64 arm` - view limitations
- `LD_FLAGS` - build flags. Default: `-X main.version=$(VERSION) -s -w`
- `SOURCE_FILES` - used for the test command. Default: `./...`
- `TEST_PATTERN` - Default: `.`
- `TEST_OPTIONS` - Default: `-v -failfast -race`
- `TEST_TIMEOUT` - Default: `2m`
- `LINT_VERSION` - version of golangci-lint. Default: `1.15.0`

## Limitations
- if you build for darwin the archs `386` and `arm` are omitted
- if you build for windows the arch `arm` is omitted
- building the docker container is currently only possible for linux-amd64
- The docker-release functionality is currently in implementation

## ToDo
- Configuration options for linter
- Configuration for docker image building
- travis-ci / circle-ci config files

## Contribution
Feel free to create an PR with additional functionality but please create a issue in the first place to discuss if the change should be in this repo or in a fork

## Used toolings
- [golangci-lint](https://github.com/golangci/golangci-lint) - linter
- [go-junit-report](https://github.com/jstemmer/go-junit-report) - junit converter for jenkins reports