package spacelift_test

import data.spacelift
import rego.v1

# Test case for denying proposed run with too many changes.
test_deny_for_proposed_run_with_too_many_changes if {
	inp := {
		"spacelift": {"run": {"type": "PROPOSED"}},
		"terraform": {"resource_changes": [
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
		]},
	}
	count(spacelift.warn) == 0 with input as inp
	spacelift.deny["More than 50 changes (51)"] with input as inp
}

# Test case for denying tracked with too many changes.
test_deny_for_tracked_run_with_too_many_changes if {
	inp := {
		"spacelift": {"run": {"type": "TRACKED"}},
		"terraform": {"resource_changes": [
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
		]},
	}
	count(spacelift.deny) == 0 with input as inp
	spacelift.warn["More than 50 changes (51)"] with input as inp
}

# Test case if no-op changes are included.
test_no_op_changes if {
	inp := {
		"spacelift": {"run": {"type": "TRACKED"}},
		"terraform": {"resource_changes": [
			{"change": {"actions": ["no-op"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
			{"change": {"actions": ["delete"]}},
		]},
	}
	count(spacelift.deny) == 0 with input as inp
	count(spacelift.warn) == 0 with input as inp
}

# Test case tracked run for no warning for reasonable commit.
test_no_warn_for_tracked_run_with_reasonable_commit if {
	inp := {
		"spacelift": {"run": {"type": "TRACKED"}},
		"terraform": {"resource_changes": [{"change": {"actions": ["delete"]}}]},
	}
	count(spacelift.deny) == 0 with input as inp
	count(spacelift.warn) == 0 with input as inp
}

# Test case tracked run for no denying for reasonable commit.
test_no_deny_for_proposed_run_with_reasonable_commit if {
	inp := {
		"spacelift": {"run": {"type": "PROPOSED"}},
		"terraform": {"resource_changes": [{"change": {"actions": ["delete"]}}]},
	}
	count(spacelift.deny) == 0 with input as inp
	count(spacelift.warn) == 0 with input as inp
}
