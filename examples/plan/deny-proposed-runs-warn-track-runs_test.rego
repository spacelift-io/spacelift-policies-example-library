package spacelift_test

import data.spacelift
import rego.v1

# Test case warning for a tracked run.
test_warn_tracked_runs if {
	inp := {
		"spacelift": {"run": {"type": "TRACKED"}},
		"terraform": {"resource_changes": [{
			"address": "aws_iam_user.user_1",
			"type": "aws_iam_user",
			"change": {"actions": ["create"]},
		}]},
	}
	count(spacelift.deny) == 0 with input as inp
	spacelift.warn["Do not create IAM users: (aws_iam_user.user_1)"] with input as inp
}

# Test case deny for a proposed run.
test_deny_proposed_runs if {
	inp := {
		"spacelift": {"run": {"type": "PROPOSED"}},
		"terraform": {"resource_changes": [{
			"address": "aws_iam_user.user_1",
			"type": "aws_iam_user",
			"change": {"actions": ["create"]},
		}]},
	}
	count(spacelift.warn) == 0 with input as inp
	spacelift.deny["Do not create IAM users: (aws_iam_user.user_1)"] with input as inp
}
