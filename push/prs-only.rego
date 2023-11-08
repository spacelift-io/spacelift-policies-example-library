package spacelift

# This policy triggers proposed runs only if a PR exists,
# and tracked runs only from PR merges.
# All non-PR events are ignored.

is_pr {
	not is_null(input.pull_request)
}

track {
	is_pr
	input.push.branch == input.stack.branch
}

propose {
	is_pr
}

ignore {
	not is_pr
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
