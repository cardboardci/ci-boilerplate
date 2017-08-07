#!/bin/sh

# Tests
#
# A set of common functions that should be tested on the docker image.

install()
{
    apk add --update zip >/dev/null 2>&1
}