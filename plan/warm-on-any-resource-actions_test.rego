package spacelift

# Test cases for is_destructive_action
test_is_destructive_action_delete {
	is_destructive_action("delete")
}

test_is_destructive_action_create {
	is_destructive_action("create")
}

test_is_destructive_action_update {
	is_destructive_action("update")
}

test_is_destructive_action_non_destructive {
	not is_destructive_action("read")
}

# Test cases for warn
test_warn_with_delete {
	msg := "Warning: Resource 'example.resource' is being deleted"
	warn[msg] with input as {"terraform": {"resource_changes": [{
		"address": "example.resource",
		"change": {"actions": ["delete"]},
	}]}}
}

test_warn_with_create {
	msg := "Warning: Resource 'example.resource' is being created"
	warn[msg] with input as {"terraform": {"resource_changes": [{
		"address": "example.resource",
		"change": {"actions": ["create"]},
	}]}}
}

test_warn_with_update {
	msg := "Warning: Resource 'example.resource' is being updated"
	warn[msg] with input as {"terraform": {"resource_changes": [{
		"address": "example.resource",
		"change": {"actions": ["update"]},
	}]}}
}

test_warn_without_destructive_action {
	input := {"terraform": {"resource_changes": [{
		"address": "example.resource",
		"change": {"actions": ["read"]},
	}]}}
	no_warnings := {msg |
		warn[msg] with input as input
	}
	count(no_warnings) == 0
}
