package spacelift

# This example plan policy prevents you from creating resources of type random_id
#
# You can read more about plan policies here:
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy

deny[sprintf("Don't create random ID %s", [resource.address])] {
	resource := input.terraform.resource_changes[_]
	resource.change.actions[_] == "create"
	resource.type == "random_id"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs

sample = true
