SHELL := /bin/bash

run:
	go run main.go

# ==============================================================================
# Building containers

VERSION := 1.0

all: sales-api

sales-api:
	docker build \
		-f zarf/docker/Dockerfile.sales-api \
		-t b65b0111-kr1-registry.container.cloud.toast.com/sales-api-amd64:$(version) \
		--build-arg PACKAGE_NAME=sales-api \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.
# ==============================================================================

docker-push:
	docker push b65b0111-kr1-registry.container.cloud.toast.com/sales-api-amd64:$(version)

k8s-deploy:
	./zarf/k8s/deploy/deploy.sh $(version)

run:
	go run app/sales-api/main.go

runa:
	go run app/admin/main.go

tidy:
	go mod tidy
	go mod vendor

test:
	go test -v ./... -count=1
	#staticcheck ./...
