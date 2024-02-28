package spacelift_test

import data.spacelift
import future.keywords.if

# Test tracking on tracked branch without triggering a run
test_track_on_tracked_branch if {
	input := {
		"push": {"branch": "main"},
		"stack": {"branch": "main"},
	}
	spacelift.track with input as input
	spacelift.notrigger
}

# Test proposing on non-tracked branch
test_propose_on_non_tracked_branch if {
	input := {
		"push": {"branch": "develop"},
		"stack": {"branch": "main"},
	}
	spacelift.propose with input as input
	spacelift.notrigger
}
