package spacelift_test

import data.spacelift
import rego.v1

# Test case for not warning for trusted engineers
test_no_warn_for_trusted_engineers if {
	count(spacelift.warn) == 0 with input as {"spacelift": {"commit": {"author": "alice"}}}
}

# Test case for warning for untrusted engineers
test_warn_for_untrusted_engineers if {
	spacelift.warn["michiel is not on the allow list - human review required"] with input as {"spacelift": {"commit": {"author": "michiel"}}}
}
