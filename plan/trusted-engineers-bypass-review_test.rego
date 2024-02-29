package spacelift

# Test case for not warning for trusted engineers
test_no_warn_for_trusted_engineers {
	count(warn) == 0 with input as {"spacelift": {"commit": {"author": "alice"}}}
}

# Test case for warning for untrusted engineers
test_warn_for_untrusted_engineers {
	warn["michiel is not on the allow list - human review required"] with input as {"spacelift": {"commit": {"author": "michiel"}}}
}
