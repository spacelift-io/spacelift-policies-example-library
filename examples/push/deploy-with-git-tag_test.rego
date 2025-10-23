package spacelift_test

import rego.v1

import data.spacelift

test_track_with_valid_semver_tag if {
	test_input := {"push": {"tag": "1.0.0"}}
	spacelift.track with input as test_input
}

test_not_track_with_non_semver_tag if {
	test_input := {"push": {"tag": "v1"}}
	not spacelift.track with input as test_input
}

# Test for proposing changes on non-matching branch push
test_propose_on_non_matching_branch if {
	test_input := {
		"push": {
			"branch": "feature",
			"tag": "",
		},
		"stack": {"branch": "main"},
	}
	spacelift.propose with input as test_input
}
