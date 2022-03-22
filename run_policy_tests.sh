#!/bin/bash

set -e

if [ -z $OPA_PATH ]; then
    OPA_PATH=opa
fi

tests=$(find . -type f -regex ".*_test\.rego")

# OPA doesn't like it if multiple rego files define the same rules, so iterate over
# all the test files and run `opa test` separately.
for test_file in $tests; do
    target="${test_file/_test.rego/.rego}"

    echo "Testing $target with $test_file"
    $OPA_PATH test $test_file $target -v
done

echo "Tests OK"
