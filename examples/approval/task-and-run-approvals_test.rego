package spacelift_test

import data.spacelift
import rego.v1

# Test that a run in the "UNCONFIRMED" state requires approval
test_unconfirmed_requires_approval if {
	spacelift.requires_approval with input as {"run": {"state": "UNCONFIRMED"}}
}

# Test that a run of type "TASK" requires approval
test_task_requires_approval if {
	spacelift.requires_approval with input as {"run": {"type": "TASK"}}
}

# Test that a run with command "ls" (from the task_allowlist) is approved
test_ls_command_auto_approve if {
	spacelift.approve with input as {
		"run": {"command": "ls", "state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": [],
		}},
	}
}

# Test that a run with command "ps" (from the task_allowlist) is approved
test_ps_command_auto_approve if {
	spacelift.approve with input as {
		"run": {"command": "ps", "state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": [],
		}},
	}
}

# Test that a run with command not in task_allowlist isn't automatically approved
test_not_in_task_allowlist if {
	not spacelift.approve with input as {
		"run": {"command": "mkdir", "state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": [],
			"rejections": [],
		}},
	}
}

# Test that a run with 2 approvals and 0 rejections is approved
test_two_approvals_zero_rejections if {
	spacelift.approve with input as {
		"run": {"type": "TASK", "state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1", "user2"],
			"rejections": [],
		}},
	}
}

# Test that a run with 1 approval and 0 rejections isn't approved
test_one_approval_zero_rejections if {
	not spacelift.approve with input as {
		"run": {"type": "TASK", "state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1"],
			"rejections": [],
		}},
	}
}

# Test that a run with 2 approvals and 1 rejection isn't approved
test_two_approvals_one_rejection if {
	not spacelift.approve with input as {
		"run": {"type": "TASK", "state": "UNCONFIRMED"},
		"reviews": {"current": {
			"approvals": ["user1", "user2"],
			"rejections": ["user3"],
		}},
	}
}
