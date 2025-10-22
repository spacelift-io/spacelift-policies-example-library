package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# In this example, each Unconfirmed run will require two approvals -
# including proposed runs triggered by Git events. Additionally,
# the run should not have more than one rejection. Everyone who rejects the run will
# need to change their mind in order for the run to go through.

approve if {
	input.run.state != "UNCONFIRMED"
}

approve if {
	count(input.reviews.current.approvals) > 1
}

reject if {
	count(input.reviews.current.rejections) > 1
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
