package spacelift

import future.keywords.if

# This policy triggers proposed runs only if a PR exists,
# and tracked runs only from PR merges.
# All non-PR events are ignored.

is_pr if {
	not is_null(input.pull_request)
}

track if {
	is_pr
	input.push.branch == input.stack.branch
}

propose if {
	is_pr
}

ignore if {
	not is_pr
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
