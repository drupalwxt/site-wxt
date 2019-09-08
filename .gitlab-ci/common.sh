#!/bin/bash

docker_login () {
  if [[ -n "$DOCKER_USERNAME" && -n "$DOCKER_PASSWORD" && -n "$DOCKER_REGISTRY" ]]; then
    echo "Logging into Docker Registry..."
    docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD" "$DOCKER_REGISTRY"
    echo ""
  else
    echo "Cannot login to docker.. No credentials or registry found."
    return 1
  fi
}

declare -x -f docker_login

docker_pull_images () {
  echo "Pulling images from Docker Registry..."
  docker_login
  docker pull "$DOCKER_REPOSITORY:$DOCKER_TAG"
  docker pull "$DOCKER_REPOSITORY:$DOCKER_TAG-nginx"

  # Tag to wcms/site-stc-rdc, which is expected by the sub-containers
  echo docker tag "$DOCKER_REPOSITORY:$DOCKER_TAG" "$PROJECT_NAME:latest"
  echo docker tag "$DOCKER_REPOSITORY:$DOCKER_TAG" "$PROJECT_NAME:latest"

  docker tag "$DOCKER_REPOSITORY:$DOCKER_TAG" "$PROJECT_NAME:latest"
  docker tag "$DOCKER_REPOSITORY:$DOCKER_TAG-nginx" "$PROJECT_NAME-nginx:latest"
  echo ""
}

declare -x -f docker_pull_images
