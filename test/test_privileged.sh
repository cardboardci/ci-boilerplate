#!/bin/sh

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
    function assertEquals()
    {
        msg=$1
        expected=$2
        actual=$3

        if [ "$expected" != "$actual" ]; then
            echo "$msg: FAILED: EXPECTED=$expected ACTUAL=$actual"
        else
            echo "$msg: PASSED"
        fi
    }

    echo "Testing image for privileged."
    mkdir -p $BIN_DIR
    (
      RESULT=$(install)
      assertEquals "install to image" 0 $?
    )
)