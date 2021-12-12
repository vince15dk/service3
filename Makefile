SHELL := /bin/bash

# expvarmon -ports=":4000" -vars="build,requests,goroutines,errors,panics,mem:memstats.Alloc"
# hey -m GET -c 100 -n 10000  http://localhost:3000/v1/test

# To generate a private/public key PEM file.
# openssl genpkey -algorithm RSA -out private.pem -pkeyopt rsa_keygen_bits:2048
# openssl rsa -pubout -in private.pem -out public.pem

# Testing Auth
# curl -il http://localhost:3000/v1/testauth
# curl -il -H "Authorization: Bearer ${TOKEN}" http://localhost:3000/v1/testauth

# ==============================================================================
# Building containers

VERSION := 1.0

all: sales-api

deploy: sales-api docker-push k8s-deploy

sales-api:
	docker build \
		-f zarf/docker/Dockerfile.sales-api \
		-t 89e26523-kr1-registry.container.cloud.toast.com/service/sales-api-amd64:$(version) \
		--build-arg PACKAGE_NAME=sales-api \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		.
# ==============================================================================

docker-push:
	docker push 89e26523-kr1-registry.container.cloud.toast.com/service/sales-api-amd64:$(version)

k8s-deploy:
	./zarf/k8s/deploy/deploy.sh $(version)

run:
	go run app/services/sales-api/main.go | go run app/tooling/logfmt/main.go

admin:
	go run app/tooling/admin/main.go

tidy:
	go mod tidy
	go mod vendor

test:
	go test -v ./... -count=1
	#staticcheck ./...

logs:
	kubectl logs -l app=sales-api -n myservice3 --all-containers=true -f --tail=100 | go run app/tooling/logfmt/main.go

push:
	git add -A
	git commit -m "update"
	git push origin master

pull:
	git pull origin master

# ./... walk through the entire project tree
# -count=1 ignores the cache and run it everytime
test:
	go test ./... -count=1
	staticcheck -checks=all ./...