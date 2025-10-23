package spacelift_test

import rego.v1

import data.spacelift

test_propose_for_pr if {
	test_input := {
		"pull_request": {"action": "commented"},
		"push": {"branch": "feature"},
		"stack": {"branch": "main"},
	}
	spacelift.propose with input as test_input
}

test_track_on_pr_merge if {
	test_input := {
		"pull_request": {"action": "merged"},
		"push": {"branch": "main"},
		"stack": {"branch": "main"},
	}
	spacelift.track with input as test_input
}

test_ignore_non_pr_events if {
	test_input := {
		"push": {"branch": "feature"},
		"stack": {"branch": "main"},
	}
	spacelift.ignore with input as test_input
}
