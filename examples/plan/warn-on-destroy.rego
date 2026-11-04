package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Destroy runs destroy the stack's resources right after the destroy plan unless a plan policy warns.
# A warning stops the run in the Unconfirmed state, where someone has to review the destroy plan
# and confirm or discard it.
warn contains sprintf("Destroy runs require manual confirmation (%d resources to destroy)", [count(deleted)]) if {
	input.spacelift.run.type == "DESTROY"
}

deleted contains resource.address if {
	some resource in input.terraform.resource_changes
	"delete" in resource.change.actions
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
