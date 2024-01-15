package spacelift_test

# Import the testing library
import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Test - Approve if not a task
test_not_a_task_approves if {
	not spacelift.approve with input as {"run": {"type": "TASK"}}
}

# Test - Approve if command is in the allowlist
test_command_in_allowlist_approves if {
	spacelift.approve with input as {"run": {"command": "ls"}}
	spacelift.approve with input as {"run": {"command": "ps"}}
}

# Test - Do not approve if command is not in the allowlist
test_command_not_in_allowlist_does_not_approve if {
	not spacelift.approve with input as {"run": {"command": "not_allowed_command"}}
}

# Test - Approve with two or more approvals
test_two_or_more_approvals if {
	spacelift.approve with input as {"reviews": {"current": {"approvals": [{"author": "user1"}, {"author": "user2"}]}}}
}

# Test - Do not approve with less than two approvals
test_less_than_two_approvals_does_not_approve if {
	not spacelift.approve with input as {"reviews": {"current": {"approvals": [{"author": "user1"}]}}}
}
