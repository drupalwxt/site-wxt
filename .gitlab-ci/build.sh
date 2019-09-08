#!/bin/bash

set -eou pipefail

if [[ -f docker/Dockerfile ]]; then
  # GitLab credentials
  GIT_USERNAME="${GIT_USERNAME:-gitlab-ci-token}"
  GIT_PASSWORD="${GIT_PASSWORD:-$CI_JOB_TOKEN}"

  HTTP_PROXY=${HTTP_PROXY:-}

  # PHP-FPM
  echo "Building Drupal PHP-FPM container..."
  docker build -f docker/Dockerfile \
            -t "$DOCKER_REPOSITORY:$DOCKER_TAG" \
            --build-arg http_proxy=$HTTP_PROXY \
            --build-arg HTTP_PROXY=$HTTP_PROXY \
            --build-arg https_proxy=$HTTP_PROXY \
            --build-arg HTTPS_PROXY=$HTTP_PROXY \
            --build-arg GIT_USERNAME=$GIT_USERNAME \
            --build-arg GIT_PASSWORD=$GIT_PASSWORD .

    echo "Pushing to Docker Registry..."
    docker_login
    docker push "$DOCKER_REPOSITORY:$DOCKER_TAG"
else
  echo "No Dockerfile found at docker/Dockerfile" 1>&2
  exit 1
fi

if [[ -f docker/images/nginx/Dockerfile ]]; then
  # Nginx
  echo "Building Nginx container w/Multi Stage Build docroot..."
  docker build -f docker/images/nginx/Dockerfile \
            -t "$DOCKER_REPOSITORY:$DOCKER_TAG-nginx" \
            --build-arg http_proxy=$HTTP_PROXY \
            --build-arg HTTP_PROXY=$HTTP_PROXY \
            --build-arg https_proxy=$HTTP_PROXY \
            --build-arg HTTPS_PROXY=$HTTP_PROXY \
            --build-arg GIT_USERNAME=$GIT_USERNAME \
            --build-arg GIT_PASSWORD=$GIT_PASSWORD \
            --build-arg BASE_IMAGE=$DOCKER_REPOSITORY:$DOCKER_TAG .


  echo "Pushing to Docker Registry..."
  docker_login
  docker push "$DOCKER_REPOSITORY:$DOCKER_TAG-nginx"
  echo ""
else
  echo "No Dockerfile found at docker/images/nginx/Dockerfile" 1>&2
  exit 1
fi
