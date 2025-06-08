default: docker_build

DOCKER_IMAGE ?= agilebeat/zookeeper
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)

ifeq ($(GIT_BRANCH), main)
	DOCKER_TAG = latest
else
	DOCKER_TAG = $(GIT_BRANCH)
endif

docker_build:
	@echo "Building image $(DOCKER_IMAGE):$(DOCKER_TAG) with ZK_VERSION=$(DOCKER_TAG)"
	@echo "docker build --debug \
	  --build-arg ZK_VERSION=$(DOCKER_TAG) \
	  --build-arg VCS_REF=`git rev-parse --short HEAD` \
	  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	  -t $(DOCKER_IMAGE):$(DOCKER_TAG) ."
	@docker build --debug \
	  --build-arg ZK_VERSION=$(DOCKER_TAG) \
	  --build-arg VCS_REF=`git rev-parse --short HEAD` \
	  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	  -t $(DOCKER_IMAGE):$(DOCKER_TAG) .
	  
docker_push:
	# Push to DockerHub
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)

test:
	docker run --rm $(DOCKER_IMAGE):$(DOCKER_TAG) zkServer.sh version
