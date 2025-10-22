package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy ensures that the listed resource types will be created before being deleted to avoid an incident

always_create_first := {"aws_batch_compute_environment"}

deny contains sprintf(message, [resource.address]) if {
	message := "Always create before deleting (%s)"
	resource := input.terraform.resource_changes[_]

	always_create_first[resource.type]

	some i_create, i_delete
	resource.change.actions[i_create] == "create"
	resource.change.actions[i_delete] == "delete"

	i_delete < i_create
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
