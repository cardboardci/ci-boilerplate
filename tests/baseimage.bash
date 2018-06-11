#!/usr/bin/env bats

#
# Filesystem
#
DIR_TESTS="$(dirname $(readlink -f "$0"))"

DIR_LIBRARY="${DIR_TESTS}/lib"
DIR_RESOURCES="${DIR_TESTS}/resources"
DIR_TARGET="${DIR_TESTS}/target"

#
# Tests
#
@test "user is not root" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" id -u
    echo "status: $status"
    echo "output: $output"
    [ "$output" != "0" ]
}

@test "tmp is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/tmp/ | wc -l"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "apt-get is disabled" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" apt-get update
    echo "status: $status"
    echo "output: $output"
    [ "$status" -ne 0 ]
}