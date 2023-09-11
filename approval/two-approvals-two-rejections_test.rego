package spacelift

# Test that a run in the "UNCONFIRMED" state is not approved
test_unconfirmed_run_not_approved {
	not approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": [],
		}},
	}
}

# Test that a run with 2 approvals is approved
test_two_approvals {
	approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1", "user2"],
			"rejections": [],
		}},
	}
}

# Test that a run with 1 approval is not approved
test_one_approval_not_enough {
	not approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1"],
			"rejections": [],
		}},
	}
}

# Test that a run with more than 1 rejection is rejected
test_more_than_one_rejection {
	reject with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": ["user1", "user2"],
		}},
	}
}

# Test that a run with 1 rejection is not rejected
test_one_rejection {
	not reject with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": ["user1"],
		}},
	}
}
