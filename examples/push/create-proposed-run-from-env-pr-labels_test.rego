package spacelift_test

import rego.v1

import data.spacelift

# Test proposing runs for matching env: prefixed labels
test_propose_for_matching_env_labels if {
	test_input := {
		"stack": {"labels": ["env:production", "env:staging"]},
		"pull_request": {"labels": ["env:production"]},
	}
	spacelift.propose with input as test_input
}
