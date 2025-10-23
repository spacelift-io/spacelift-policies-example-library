package spacelift_test

import data.spacelift
import rego.v1

# Test Case 1: Dependency and State Match
test_dependency_and_state_match if {
	spacelift.trigger["stack-two"] with input as {
		"run": {
			"state": "FINISHED",
			"type": "TRACKED",
		},
		"stack": {"id": "stack-one"},
		"stacks": [{
			"id": "stack-two",
			"labels": ["depends-on:stack-one|state:FINISHED"],
		}],
	}
}

# Test Case 2: Dependency Match but State Mismatch
test_dependency_match_state_mismatch if {
	count(spacelift.trigger) == 0 with input as {
		"run": {
			"state": "FAILED",
			"type": "TRACKED",
		},
		"stack": {"id": "stack-one"},
		"stacks": [{
			"id": "stack-two",
			"labels": ["depends-on:stack-one|state:FINISHED"],
		}],
	}
}
