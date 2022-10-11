#!/bin/bash

tests=$(find . -type f -regex '.*_test\.rego$')
for test in $tests; do
    opa test -v $test ${test/_test.rego/.rego}
    echo
done
