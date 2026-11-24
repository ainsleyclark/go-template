BINARY ?= $(notdir $(CURDIR))

setup: # Download dependencies and install the commit-msg hook
	go mod download
	git config core.hooksPath .githooks
.PHONY: setup

build: # Build the binary into bin/
	go build -o bin/$(BINARY) .
.PHONY: build

run: # Run the app
	go run .
.PHONY: run

format: # Run gofmt
	go fmt ./...
.PHONY: format

lint: # Run the linter, fixing what it can
	golangci-lint run ./... --fix --config=.golangci.yaml
.PHONY: lint

test: # Run the Go tests with coverage
	go clean -testcache && go test ./... -coverprofile=coverage.out -covermode=atomic
.PHONY: test

test-race: # Run the Go tests with the race detector
	go clean -testcache && go test -race ./... -coverprofile=coverage.out -covermode=atomic
.PHONY: test-race

vuln: # Run govulncheck
	go tool govulncheck ./...
.PHONY: vuln

cover: test # Run the tests and open the coverage report
	go tool cover -html=coverage.out
.PHONY: cover

all: # Format, lint, test and check for vulnerabilities
	$(MAKE) format
	$(MAKE) lint
	$(MAKE) test-race
	$(MAKE) vuln
.PHONY: all

help: # Display this help
	@awk 'BEGIN {FS = ":.*#"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?#/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
.PHONY: help
