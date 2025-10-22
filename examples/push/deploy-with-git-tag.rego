package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy deploys from a newly created git tag rather than from a branch

track if {
	regex.match(`^\d+\.\d+\.\d+$`, input.push.tag)
}

propose if {
	input.push.branch != input.stack.branch
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
