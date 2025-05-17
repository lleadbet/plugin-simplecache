.PHONY: lint test vendor clean

export GO111MODULE=on

default: lint test

lint:
	golangci-lint run

test:
	go test -v -cover ./...

yaegi_test:
	yaegi test -v .

vendor:
	go mod vendor

clean:
	rm -rf ./vendor

.PHONY: update-go-deps 

update-go-deps: @echo ">> updating Go dependencies" @for m in $$(go list -mod=readonly -m -f '{{ if and (not .Indirect) (not .Main)}}{{.Path}}{{end}}' all); do \ go get $$m; \ done go mod tidy ifneq (,$(wildcard vendor)) go mod vendor endif

