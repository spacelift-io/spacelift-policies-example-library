package spacelift

# Test that a run in a state other than "UNCONFIRMED" is approved by the first rule
test_other_than_unconfirmed_state_approved {
	approve with input as {
		"run": {"state": "QUEUED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": [],
		}},
	}
}

# Test that a run in the "UNCONFIRMED" state with 2 approvals and 0 rejections is approved by the second rule
test_two_approvals_unconfirmed_state {
	approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1", "user2"],
			"rejections": [],
		}},
	}
}

# Test that a run in the "UNCONFIRMED" state with 1 approval and 0 rejections is not approved by the second rule
test_one_approval_unconfirmed_state_not_approved {
	not approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1"],
			"rejections": [],
		}},
	}
}

# Test that a run in the "UNCONFIRMED" state with 0 approvals and 1 rejection is not approved by the second rule
test_one_rejection_unconfirmed_state_not_approved {
	not approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": ["user1"],
		}},
	}
}
