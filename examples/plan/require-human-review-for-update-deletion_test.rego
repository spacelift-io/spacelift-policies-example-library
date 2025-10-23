package spacelift_test

import data.spacelift
import rego.v1

# Test case for no warning on creation.
test_warn_on_creation if {
	count(spacelift.warn) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {"actions": ["create"]},
	}]}}
}

# Test case for warning on update.
test_warn_on_update if {
	spacelift.warn["action 'update' requires human review (random_password.password_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {"actions": ["update"]},
	}]}}
}

# Test case for warning on delete.
test_warn_on_deletion if {
	spacelift.warn["action 'delete' requires human review (random_password.password_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {"actions": ["delete"]},
	}]}}
}
