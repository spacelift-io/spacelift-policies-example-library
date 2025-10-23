package spacelift_test

import data.spacelift
import rego.v1

# Test that a run in the "UNCONFIRMED" state is not approved
test_unconfirmed_run_not_approved if {
	not spacelift.approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": [],
		}},
	}
}

# Test that a run with 2 approvals is approved
test_two_approvals if {
	spacelift.approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1", "user2"],
			"rejections": [],
		}},
	}
}

# Test that a run with 1 approval is not approved
test_one_approval_not_enough if {
	not spacelift.approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1"],
			"rejections": [],
		}},
	}
}

# Test that a run with more than 1 rejection is rejected
test_more_than_one_rejection if {
	spacelift.reject with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": ["user1", "user2"],
		}},
	}
}

# Test that a run with 1 rejection is not rejected
test_one_rejection if {
	not spacelift.reject with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": ["user1"],
		}},
	}
}
