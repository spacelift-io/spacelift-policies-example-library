package spacelift

# Adding resources may ultimately cost a lot of money but it's generally pretty safe from an operational perspective.
# Let's use a `warn` rule to allow changes with only added resources to get automatically applied,
# and require all others to get a human review.

warn[sprintf(message, [action, resource.address])] {
	message := "action '%s' requires human review (%s)"
	review := {"update", "delete"}

	resource := input.terraform.resource_changes[_]
	action := resource.change.actions[_]

	review[action]
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
