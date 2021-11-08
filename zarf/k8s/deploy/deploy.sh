#!/bin/bash
version=$1
export version=$version
envsubst < ./zarf/k8s/deploy/app.yaml | kubectl apply -n myservice -f -