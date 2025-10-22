package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This example plan policy prevents you from creating weak passwords, and warns
# you when passwords are meh.
#
# You can read more about plan policies here:
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy

deny contains sprintf("We require that passwords have at least 16 characters (%s)", [resource.address]) if {
	resource := new_password[_]
	resource.change.after.length < 16
}

warn contains sprintf("We advise that passwords have at least 20 characters (%s)", [resource.address]) if {
	resource := new_password[_]
	resource.change.after.length < 20
}

new_password contains resource if {
	resource := input.terraform.resource_changes[_]
	"create" in resource.change.actions
	resource.type == "random_password"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
