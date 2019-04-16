#!/bin/bash
#
# A simple script to start a Docker container
# and run Testinfra in it
# Original script: https://gist.github.com/renatomefi/bbf44d4e8a2614b1390416c6189fbb8e
# Author: @renatomefi https://github.com/renatomefi
#

set -eEuo pipefail

# The first parameter is a Docker tag or image id
declare -r DOCKER_NGINX_TAG="$1"

declare -r TEST_SUITE="nginx_e2e"

# Finally, run the tests!
docker run --net="host" --rm -t \
    -v "$(pwd)/test/e2e:/tests" \
    -v "$(pwd)/tmp/test-results:/results" \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    renatomefi/docker-testinfra:2 \
    -m "$TEST_SUITE" --junitxml="/results/http-e2e-$DOCKER_NGINX_TAG.xml" \
    --verbose --tag="$1"
