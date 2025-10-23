package spacelift_test

import rego.v1

import data.spacelift

# Test that a track action is triggered by a specific pull request comment
test_track_for_specific_pr_comment if {
	test_input := {
		"pull_request": {
			"action": "commented",
			"comment": "/spacelift deploy stack123",
		},
		"stack": {"id": "stack123"},
	}
	spacelift.track with input as test_input
}
