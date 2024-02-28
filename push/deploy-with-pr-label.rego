package spacelift

import future.keywords.if
import future.keywords.in

# This policy responds to a particular PR label ("deploy") to automatically deploy changes

is_pr if {
	not is_null(input.pull_request)
}

labeled if {
	"deploy" in input.pull_request.labels
}

track if {
	is_pr
	labeled
}

propose := true

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
