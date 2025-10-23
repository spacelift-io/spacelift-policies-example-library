package spacelift_test

import data.spacelift
import rego.v1

# Test for denied instances
test_deny_t2_2xlarge if {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.2xlarge"}},
	}]}}
	count(spacelift.deny) == 1 with input as inp
	count(spacelift.warn) == 0 with input as inp
}

test_deny_t2_xlarge if {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.xlarge"}},
	}]}}
	count(spacelift.deny) == 1 with input as inp
	count(spacelift.warn) == 0 with input as inp
}

# Test for allowed instances (should not warn or deny)
test_allow_t2_micro if {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.micro"}},
	}]}}
	count(spacelift.deny) == 0 with input as inp
	count(spacelift.warn) == 0 with input as inp
}

test_allow_t2_small if {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.small"}},
	}]}}
	count(spacelift.deny) == 0 with input as inp
	count(spacelift.warn) == 0 with input as inp
}

test_allow_t2_nano if {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.nano"}},
	}]}}
	count(spacelift.deny) == 0 with input as inp
	count(spacelift.warn) == 0 with input as inp
}

# Test for instances that should generate a warning
test_warn_t2_medium if {
	inp := {"terraform": {"resource_changes": [{
		"address": "aws_instance.example",
		"type": "aws_instance",
		"change": {"after": {"instance_type": "t2.medium"}},
	}]}}
	count(spacelift.deny) == 0 with input as inp
	count(spacelift.warn) == 1 with input as inp
}
