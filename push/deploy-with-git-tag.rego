package spacelift

# This policy deploys from a newly created git tag rather than from a branch

track {
	re_match(`^\d+\.\d+\.\d+$`, input.push.tag)
}

propose {
	input.push.branch != input.stack.branch
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
