package spacelift_test

import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Test Case 1: Failed and Tracked Run without flags
test_failed_and_tracked_run_without_flags if {
	result := spacelift.trigger with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"flags": [],
		},
		"stack": {
			"id": "stack-one",
			"labels": [],
		},
	}
	result["stack-one"]
}

# Test Case 2: Failed and Tracked Run with flags
test_failed_and_tracked_run_with_flags if {
	result := spacelift.trigger with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"flags": ["spacelift_retry:1"],
		},
		"stack": {
			"id": "stack-one",
			"labels": [],
		},
	}
	result["stack-one"]
}

# Test Case 3: Failed and Tracked Run with flags at max
test_failed_and_tracked_run_with_flags_at_max if {
	count(spacelift.trigger) == 0 with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"flags": ["spacelift_retry:3"],
		},
		"stack": {
			"id": "stack-one",
			"labels": [],
		},
	}
}

# Test Case 4: LABELS: Failed and Tracked Run without flags
test_failed_and_tracked_run_labels_without_flags if {
	result := spacelift.trigger with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"flags": [],
		},
		"stack": {
			"id": "stack-one",
			"labels": ["spacelift_retry:2"],
		},
	}
	result["stack-one"]
}

# Test Case 5: LABELS: Failed and Tracked Run with flags
test_failed_and_tracked_run_labels_with_flags if {
	result := spacelift.trigger with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"flags": ["spacelift_retry:1"],
		},
		"stack": {
			"id": "stack-one",
			"labels": ["spacelift_retry:2"],
		},
	}
	result["stack-one"]
}

# Test Case 6: LABELS: Failed and Tracked Run with flags at max
test_failed_and_tracked_run_labels_with_flags_at_max if {
	count(spacelift.trigger) == 0 with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
			"flags": ["spacelift_retry:2"],
		},
		"stack": {
			"id": "stack-one",
			"labels": ["spacelift_retry:2"],
		},
	}
}
