package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

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
