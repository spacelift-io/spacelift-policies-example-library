package spacelift

# Test for denied instances
test_deny_t2_2xlarge {
	input := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.2xlarge"}},
	}]}}
	count(deny) == 1 with input as input
	count(warn) == 0 with input as input
}

test_deny_t2_xlarge {
	input := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.xlarge"}},
	}]}}
	count(deny) == 1 with input as input
	count(warn) == 0 with input as input
}

# Test for allowed instances (should not warn or deny)
test_allow_t2_micro {
	input := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.micro"}},
	}]}}
	count(deny) == 0 with input as input
	count(warn) == 0 with input as input
}

test_allow_t2_small {
	input := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.small"}},
	}]}}
	count(deny) == 0 with input as input
	count(warn) == 0 with input as input
}

test_allow_t2_nano {
	input := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.nano"}},
	}]}}
	count(deny) == 0 with input as input
	count(warn) == 0 with input as input
}

# Test for instances that should generate a warning
test_warn_t2_medium {
	input := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.medium"}},
	}]}}
	count(deny) == 0 with input as input
	count(warn) == 1 with input as input
}
