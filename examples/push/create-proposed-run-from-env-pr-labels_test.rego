package spacelift_test

import data.spacelift
import future.keywords.if

# Test proposing runs for matching env: prefixed labels
test_propose_for_matching_env_labels if {
	input := {
		"stack": {"labels": ["env:production", "env:staging"]},
		"pull_request": {"labels": ["env:production"]},
	}
	spacelift.propose with input as input
}
