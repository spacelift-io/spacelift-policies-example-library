package spacelift

warn[sprintf(message, [resource.address, action])] {
	message := "resource: %s action %s requires human review"

	review := {"delete", "update"} # Review actions include both "update" and "delete"

	resource := input.terraform.resource_changes[_]

	action := resource.change.actions[_]

	review[action]

	# Check if the resource type is among the list of sensitive resource types

	sensitive_resources := {
		"aws_iam_user",
		"aws_iam_role",
		"aws_iam_policy",
		"aws_security_group",
	}

	sensitive_resources[resource.type]
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
