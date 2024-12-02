package spacelift_test

import data.spacelift
import future.keywords.if

test_propose_for_pr if {
	input := {
		"pull_request": {"action": "commented"},
		"push": {"branch": "feature"},
		"stack": {"branch": "main"},
	}
	spacelift.propose with input as input
}

test_track_on_pr_merge if {
	input := {
		"pull_request": {"action": "merged"},
		"push": {"branch": "main"},
		"stack": {"branch": "main"},
	}
	spacelift.track with input as input
}

test_ignore_non_pr_events if {
	input := {
		"push": {"branch": "feature"},
		"stack": {"branch": "main"},
	}
	spacelift.ignore with input as input
}
