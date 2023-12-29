package spacelift

# Helper rule to generate warning messages for resources being deleted, created or updated
warn[msg] {
	resource := input.terraform.resource_changes[_]
	action := resource.change.actions[_]
	is_destructive_action(action)
	msg := sprintf("Warning: Resource '%s' is being %sd", [resource.address, action])
}

# Helper function to determine if an action is 'delete', 'create' or 'update'
is_destructive_action(action) {
	action == "delete"
}

is_destructive_action(action) {
	action == "create"
}

is_destructive_action(action) {
	action == "update"
}
