package spacelift

# This policy responds to a particular PR label ("deploy") to automatically deploy changes

is_pr {
	not is_null(input.pull_request)
}

labeled {
	input.pull_request.labels[_] = "deploy"
}

track {
	is_pr
	labeled
}

propose := true

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
