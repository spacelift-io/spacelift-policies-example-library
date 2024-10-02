#!/bin/bash

STATUS=0

tests=$(find . -type f -name '*_test\.rego')
for test in $tests; do
    opa test -v "$test" "${test/_test\.rego/.rego}"
    ((STATUS=$STATUS + $?))
    echo
done

# Instead of exiting on first failure as we would with "-e" set, exit at the
# end with sum of exit codes.
if [ $STATUS -gt 0 ]; then
  echo "Failures detected: exiting with status $STATUS" >&2
fi

exit $STATUS
