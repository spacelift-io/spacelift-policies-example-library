package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# First, let's define all conditions that require explicit
# user approval.
requires_approval if {
	input.run.state == "UNCONFIRMED"
}

requires_approval if {
	input.run.type == "TASK"
}

approve if {
	not requires_approval
}

approvals := input.reviews.current.approvals

# Let's define what it means to be approved by a director, DevOps and Security.
director_approval if {
	"Director" in approvals[_].session.teams
}

devops_approval if {
	"DevOps" in approvals[_].session.teams
}

security_approval if {
	"Security" in approvals[_].session.teams
}

# Approve when a single director approves:
approve if {
	director_approval
}

# Approve when both DevOps and Security approve:
approve if {
	devops_approval
	security_approval
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
