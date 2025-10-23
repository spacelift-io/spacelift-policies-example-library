package spacelift_test

import data.spacelift
import rego.v1

# Test case for denying resources with a certain resource type that will be deleted before created.
test_deny_non_create_before_destroy_lifecycle if {
	spacelift.deny["Always create before deleting (aws_batch_compute_environment.test_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_batch_compute_environment.test_1",
		"type": "aws_batch_compute_environment",
		"change": {"actions": ["delete", "create"]},
	}]}}
}

# Test case for allowing resources with a certain resource type that will be created before deleted.
test_allow_create_before_destroy_lifecycle if {
	count(spacelift.deny) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "aws_batch_compute_environment.test_1",
		"type": "aws_batch_compute_environment",
		"change": {"actions": ["create", "delete"]},
	}]}}
}
