package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# While in most cases you'll want your rules to only look at resources affected by the change,
# you're not limited to doing so. You can also look at all resources and force teams to remove certain resources.
# Here's an example - until all AWS resources are removed all in one go, no further changes can take place.

deny contains sprintf(message, [resource.address]) if {
	message := "We have moved to GCP, find an equivalent there (%s)"
	resource := input.terraform.resource_changes[_]

	resource.provider_name == "aws"

	# If you're just deleting, all good.
	resource.change.actions != ["delete"]
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
