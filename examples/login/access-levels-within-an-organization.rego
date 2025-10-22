package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This login policy gives everyone in the organization access to Spacelift
# and makes all members of the "DevOps" team admins.
#
# You can read more about login policies here:
# https://docs.spacelift.io/concepts/policy/login-policy

admin if {
	"DevOps" in input.session.teams
}

allow if {
	input.session.member
}

deny if {
	not allow
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
