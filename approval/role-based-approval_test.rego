package spacelift

# Test that a run in the "UNCONFIRMED" state requires approval
test_unconfirmed_requires_approval {
	requires_approval with input as {"run": {"state": "UNCONFIRMED"}}
}

# Test that a run of type "TASK" requires approval
test_task_requires_approval {
	requires_approval with input as {"run": {"type": "TASK"}}
}

# Test that a run of type "TRACKED" and state "QUEUED" is auto-approved
test_auto_approve {
	approve with input as {
		"run": {"type": "TRACKED", "state": "QUEUED"},
		"reviews": {"current": {"approvals": []}},
	}
}

# Test that a run with a director's approval is approved
test_director_approval {
	approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {"approvals": [{"session": {"teams": ["Director"]}}]}},
	}
}

# Test that a run without a director's approval is not approved
test_no_director_approval {
	not approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {"approvals": [{"session": {"teams": ["Manager"]}}]}},
	}
}

# Test that a run with both DevOps and Security approvals is approved
test_devops_security_approval {
	approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {"approvals": [
			{"session": {"teams": ["DevOps"]}},
			{"session": {"teams": ["Security"]}},
		]}},
	}
}

# Test that a run with just DevOps or Security approval is not approved
test_only_devops_approval {
	not approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {"approvals": [{"session": {"teams": ["DevOps"]}}]}},
	}
}

test_only_security_approval {
	not approve with input as {
		"run": {"state": "UNCONFIRMED"},
		"reviews": {"current": {"approvals": [{"session": {"teams": ["Security"]}}]}},
	}
}
