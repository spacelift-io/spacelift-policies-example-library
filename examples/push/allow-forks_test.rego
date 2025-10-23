package spacelift_test

import rego.v1

import data.spacelift

# Test allowing fork from a trusted user
test_allow_fork_trusted_user if {
	test_input := {"pull_request": {"head_owner": "johnwayne"}}
	spacelift.allow_fork with input as test_input
}

# Test not allowing fork from an untrusted user
test_not_allow_fork_untrusted_user if {
	test_input := {"pull_request": {"head_owner": "randomuser"}}
	not spacelift.allow_fork with input as test_input
}
