package spacelift

# Sensitive properties in "before" and "after" objects will be sanitized to protect secret values.
# Sanitization hashes the value and takes the last 8 bytes of the hash.
# If you need to compare a string property to a constant, you can use the sanitized(string) helper function.

deny["must not target the forbidden endpoint: forbidden.endpoint/webhook"] {
	resource := input.terraform.resource_changes[_]

	actions := {"create", "delete", "update"}
	actions[resource.change.actions[_]]

	resource.change.after.endpoint == sanitized("forbidden.endpoint/webhook")
}
