# Docker image tag (if tag, use tag else generate a unique identifier)
export VERSION=$(git describe --tags 2>/dev/null || echo 0.0.0)
export DOCKER_TAG=$(echo $VERSION | sed 's/8\.x-//g')-$CI_PROJECT_ID.$CI_PIPELINE_IID