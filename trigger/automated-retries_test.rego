package spacelift_test

import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Test Case 1: Failed and Tracked Run Without Trigger
test_failed_tracked_run_without_trigger if {
	result := spacelift.trigger with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"triggered_by": null,
		},
		"stack": {"id": "stack-one"},
	}
	result["stack-one"]
}

# Test Case 2: Failed and Tracked Run With Trigger
test_failed_tracked_run_with_trigger if {
	count(spacelift.trigger) == 0 with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"triggered_by": "some-policy",
		},
		"stack": {"id": "stack-one"},
	}
}

# Test Case 3: Non-Failed Run or Non-Tracked Run
test_non_failed_or_non_tracked_run if {
	count(spacelift.trigger) == 0 with input as {
		"run": {
			"state": "SUCCESS",
			"type": "TRACKED",
			"triggered_by": null,
		},
		"stack": {"id": "stack-one"},
	}
}
