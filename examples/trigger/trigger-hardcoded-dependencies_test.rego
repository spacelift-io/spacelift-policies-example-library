package spacelift_test

import rego.v1

import data.spacelift

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
