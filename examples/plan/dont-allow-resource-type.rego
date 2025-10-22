package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Note that the message here is dynamic and captures resource address to provide
# appropriate context to anyone affected by this policy. For the sake of your
# sanity and that of your colleagues, please a
#
# You can read more about plan policies here:
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy

deny contains sprintf(message, [resource.address]) if {
	message := "Static AWS credentials are evil (%s)"

	resource := input.terraform.resource_changes[_]
	"create" in resource.change.actions

	# This is what decides whether the rule captures a resource.
	# There may be an arbitrary number of conditions, and they all must
	# succeed for the rule to take effect.
	resource.type == "aws_iam_access_key"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
