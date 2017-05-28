#!/bin/sh
source lib/testbase.sh

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
BIN_DIR="${DIR}/target"

# Tests
#
# The functions that test certain functionality.

function install()
{
    apk add --update zip >/dev/null 2>&1
}

# Test Runner
#
# Runs the tests.
(
    mkdir -p $BIN_DIR
    (
      RESULT=$(install)
      assertEquals "install to image" 0 $?
    )
)