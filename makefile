REGISTRY_HOST_NAME = ishaanbahal
PROJECT_ID = golang-alpine-vips
PROJECT_NAME = golang-alpine-vips
VERSION = $(shell cat VERSION)
IMAGE = ${PROJECT_NAME}:${VERSION}
TAG_NAME = ${REGISTRY_HOST_NAME}/${IMAGE}

_buildDocker:
	@docker build --rm -t ${PROJECT_NAME} .

dockerclean:
	@docker rmi -f $(shell docker images -f dangling=true -q)

tag_docker:
	@docker tag ${PROJECT_NAME} ${TAG_NAME}

docker: print _buildDocker dockerclean tag_docker

docker_push: docker
	@docker push ${TAG_NAME}

# Can fail if tag doesn't exist in local repository
docker_push_latest:
	@docker push ${TAG_NAME}

print:
	@echo "Preparing docker image for"
	@echo "Version: "${VERSION}
	@echo "Image: "${IMAGE}
	@echo "Tag: "${TAG_NAME}