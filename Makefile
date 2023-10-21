ENV :=dev
SHELL := /bin/bash

CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

DOCKER_REPO ?=
DOCKER_PASSWORD ?=
IMAGE_TAG ?= latest

.PHONY: docker-login
docker-login:
	echo $(DOCKER_PASSWORD) | docker login -u $(DOCKER_REPO) --password-stdin

.PHONY: build-backend
build-backend:
	docker build backend -t $(DOCKER_REPO)/api:$(IMAGE_TAG) -f containers/Dockerfile.api
	docker push $(DOCKER_REPO)/api:$(IMAGE_TAG)

.PHONY: build-db
build-db:
	docker build backend -t $(DOCKER_REPO)/db:$(IMAGE_TAG) -f containers/Dockerfile.db
	docker push $(DOCKER_REPO)/db:$(IMAGE_TAG)

.PHONY: build-frontend
build-frontend:
	docker build frontend -t $(DOCKER_REPO)/web:$(IMAGE_TAG) -f containers/Dockerfile.web
	docker push $(DOCKER_REPO)/web:$(IMAGE_TAG)