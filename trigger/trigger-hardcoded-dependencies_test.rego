package spacelift_test

import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Test setup for finished runs
test_trigger_success if {
	spacelift.trigger with input as {"run": {
		"state": "FINISHED",
		"type": "TRACKED",
	}}
}

test_trigger_failure_non_finished_state if {
	count(spacelift.trigger) == 0 with input as {"run": {
		"state": "UNCONFIRMED",
		"type": "TRACKED",
	}}
}
