package spacelift

# Test case for denying creation of a resource with no enforced tags.
test_deny_creation_of_resource_with_no_enforced_tags {
	deny["resource \"random_password.password_1\" does not have all suggested tags (Name, env, owner)"] with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {
			"actions": ["create"],
			"after": {"tags_all": [{"test": "test"}]},
		},
	}]}}
}

# Test case for allowing creation of a resource with enforced tags.
test_allow_creation_of_resource_with_enforced_tags {
	count(deny) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {
			"actions": ["create"],
			"after": {"tags_all": {
				"Name": "name",
				"env": "testing",
				"owner": "spacelift.io",
			}},
		},
	}]}}
}

# Test case for allowing creation of a resource with partial enforced tags.
test_allow_creation_of_resource_with_partial_enforced_tags {
	deny["resource \"random_password.password_1\" does not have all suggested tags (env)"] with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {
			"actions": ["create"],
			"after": {"tags_all": {
				"Name": "name",
				"owner": "spacelift.io",
			}},
		},
	}]}}
}
