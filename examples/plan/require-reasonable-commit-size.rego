package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Massive changes make reviewers miserable. Let's automatically fail all changes that affect more than 50 resources.
# Let's also allow them to be deployed with mandatory human review nevertheless.

proposed := input.spacelift.run.type == "PROPOSED"

deny contains msg if {
	proposed
	msg := too_many_changes[_]
}

warn contains msg if {
	not proposed
	msg := too_many_changes[_]
}

too_many_changes contains msg if {
	threshold := 50

	res := input.terraform.resource_changes
	ret := count([r | r := res[_]; r.change.actions != ["no-op"]])
	msg := sprintf("More than %d changes (%d)", [threshold, ret])

	ret > threshold
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
