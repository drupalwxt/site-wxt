#!/bin/bash

set -eou pipefail

# Start docker
docker_pull_images
docker-compose -f docker-compose-ci.yml up -d
docker ps -a
sleep 15

# Run a site install
docker-compose -f docker-compose-ci.yml exec -T cli bash /var/www/docker/bin/cli drupal-install wxt
docker-compose -f docker-compose-ci.yml exec -T cli bash /var/www/docker/bin/cli drupal-migrate wxt
docker-compose -f docker-compose-ci.yml exec -T cli chmod 777 -R sites/default/files /var/www/files_private

# Run tests
make test
