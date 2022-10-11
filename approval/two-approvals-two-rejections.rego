package spacelift

# In this example, each Unconfirmed run will require two approvals -
# including proposed runs triggered by Git events. Additionally,
# the run should not have more than one rejection. Everyone who rejects the run will
# need to change their mind in order for the run to go through.

approve {
	input.run.state != "UNCONFIRMED"
}

approve {
	count(input.reviews.current.approvals) > 1
}

reject {
	count(input.reviews.current.rejections) > 1
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
