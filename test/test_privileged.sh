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

function version()
{
    pdf2htmlEX --version >/dev/null 2>&1
}

function install()
{
    apk add --update zip >/dev/null 2>&1
}

function single_pdf()
{
    mydir="${BIN_DIR}/simple_pdf"
    mkdir -p $mydir

    curl -o "${mydir}/simple_pdf.pdf" "https://upload.wikimedia.org/wikipedia/commons/0/05/Cheatsheet-en.pdf" >/dev/null 2>&1
    pdf2htmlEX --dest-dir "${mydir}" "${mydir}/simple_pdf.pdf" >/dev/null 2>&1
}

function multi_pdf()
{
    mydir="${BIN_DIR}/multi_pdf"
    mkdir -p $mydir

    curl -o "${mydir}/multi_pdf.pdf" "https://upload.wikimedia.org/wikipedia/commons/1/18/Editing_Wikipedia_brochure_EN.pdf" >/dev/null 2>&1
    pdf2htmlEX --dest-dir "${mydir}" "${mydir}/multi_pdf.pdf" >/dev/null 2>&1
}

function graphics_pdf()
{
    mydir="${BIN_DIR}/graphics_pdf"
    mkdir -p $mydir

    curl -o "${mydir}/graphics_pdf.pdf" "https://upload.wikimedia.org/wikipedia/commons/3/37/Detection_distribution.pdf" >/dev/null 2>&1
    pdf2htmlEX --dest-dir "${mydir}" "${mydir}/graphics_pdf.pdf" >/dev/null 2>&1
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

    echo "Testing image pdf2htmlex for privileged."
    mkdir -p $BIN_DIR
    (
      RESULT=$(version)
      assertEquals "version can successfully" 0 $?
    )

    (
      RESULT=$(install)
      assertEquals "install to image" 0 $?
    )

    (
      RESULT=$(single_pdf)
      assertEquals "converting a simple pdf with one page" 0 $?
    )

    (
      RESULT=$(multi_pdf)
      assertEquals "converting a simple pdf with multiple pages" 0 $?
    )
)