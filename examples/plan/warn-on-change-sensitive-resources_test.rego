package spacelift

# Test for `aws_iam_user` resource being updated
test_warn_update_iam_user {
	count(warn) == 1 with input as {"terraform": {"resource_changes": [{
		"address": "aws_iam_user.example",
		"type": "aws_iam_user",
		"change": {"actions": ["update"]},
	}]}}
}

# Test for `aws_iam_role` resource being deleted
test_warn_delete_iam_role {
	count(warn) == 1 with input as {"terraform": {"resource_changes": [{
		"address": "aws_iam_role.example",
		"type": "aws_iam_role",
		"change": {"actions": ["delete"]},
	}]}}
}

# Test for non-sensitive resource being updated
test_no_warn_update_ec2_instance {
	count(warn) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"actions": ["update"]},
	}]}}
}

# Test for sensitive resource being created (shouldn't trigger a warning)
test_no_warn_create_iam_policy {
	count(warn) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "aws_iam_policy.example",
		"type": "aws_iam_policy",
		"change": {"actions": ["create"]},
	}]}}
}

# Test for multiple sensitive resources being updated and deleted (should trigger multiple warnings)
test_multiple_warnings {
	count(warn) == 2 with input as {"terraform": {"resource_changes": [
		{
			"address": "aws_iam_policy.example",
			"type": "aws_iam_policy",
			"change": {"actions": ["update"]},
		},
		{
			"address": "aws_security_group.example",
			"type": "aws_security_group",
			"change": {"actions": ["delete"]},
		},
	]}}
}
