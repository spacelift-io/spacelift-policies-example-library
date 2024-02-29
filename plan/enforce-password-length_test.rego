package spacelift

# Test case for denying creation of a password with less than 16 characters.
test_deny_creation_of_password_with_less_than_16_characters {
	deny["We require that passwords have at least 16 characters (random_password.password_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {
			"actions": ["create"],
			"after": {"length": 1},
		},
	}]}}
}

# Test case for warning creation of a password between 16 and 20 characters.
test_warn_creation_of_password_between_16_and_20_characters {
	warn["We advise that passwords have at least 20 characters (random_password.password_1)"] with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {
			"actions": ["create"],
			"after": {"length": 18},
		},
	}]}}
}

# Test case for allowing creation of a password longer than 20 characters.
test_allow_creation_of_password_longer_than_20_characters {
	count(warn) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "random_password.password_1",
		"type": "random_password",
		"change": {
			"actions": ["create"],
			"after": {"length": 21},
		},
	}]}}
}
