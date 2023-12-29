package spacelift

# Test: No warning for non-destructive actions
test_no_warning_for_non_destructive {
	warn_set := {msg | msg := warn[_]}
	count(warn_set) == 0 with input as {"terraform": {"resource_changes": [{"address": "aws_instance.example", "change": {"actions": ["change"]}}]}}
}

# Test: Warning for a deleted resource
test_warning_for_deleted_resource {
	warn with input as {"terraform": {"resource_changes": [{"address": "aws_instance.example", "change": {"actions": ["delete"]}}]}} == {"Warning: Resource 'aws_instance.example' is being deleted"}
}

# Test: Warning for a recreated resource
test_warning_for_recreated_resource {
	warn with input as {"terraform": {"resource_changes": [{"address": "aws_instance.example", "change": {"actions": ["create"]}}]}} == {"Warning: Resource 'aws_instance.example' is being created"}
}

# Test: Warning for a recreated resource
test_warning_for_recreated_resource {
	warn with input as {"terraform": {"resource_changes": [{"address": "aws_instance.example", "update": {"actions": ["update"]}}]}} == {"Warning: Resource 'aws_instance.example' is being updated"}
}
