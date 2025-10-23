package spacelift_test

import rego.v1

import data.spacelift

# Test Case 1: Run failed with 'deny' outcome
test_run_failed_with_deny if {
	test_input := {
		"account": {"name": "<example>"},
		"run_updated": {
			"run": {"state": "FAILED", "id": "run123"},
			"stack": {"id": "stack123"},
			"policy_receipts": [{"name": "deny_policy", "outcome": "deny"}],
		},
	}
	result := spacelift.slack with input as test_input
	count(result) == 1
}

# Test Case 2: Run failed with 'reject' outcome
test_run_failed_with_reject if {
	test_input := {
		"account": {"name": "<example>"},
		"run_updated": {
			"run": {"state": "FAILED", "id": "run123"},
			"stack": {"id": "stack123"},
			"policy_receipts": [{"name": "reject_policy", "outcome": "reject"}],
		},
	}
	result := spacelift.slack with input as test_input
	count(result) == 1
}

# Test Case 3: Run failed with neither 'deny' nor 'reject' outcome
test_run_failed_with_neither if {
	test_input := {
		"account": {"name": "<example>"},
		"run_updated": {
			"run": {"state": "FAILED", "id": "run123"},
			"stack": {"id": "stack123"},
			"policy_receipts": [{"name": "null", "outcome": null}],
		},
	}
	result := spacelift.slack with input as test_input
	count(result) == 1
}

# Test Case 4: Run has not failed
test_run_not_failed if {
	test_input := {
		"account": {"name": "<example>"},
		"run_updated": {
			"run": {"state": "PASSED", "id": "run123"},
			"stack": {"id": "stack123"},
			"policy_receipts": [{"name": "some_policy", "outcome": "deny"}],
		},
	}
	result := spacelift.slack with input as test_input
	count(result) == 0
}
