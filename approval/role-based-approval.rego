package spacelift

import future.keywords.in

# First, let's define all conditions that require explicit
# user approval.
requires_approval {
	input.run.state == "UNCONFIRMED"
}

requires_approval {
	input.run.type == "TASK"
}

approve {
	not requires_approval
}

approvals := input.reviews.current.approvals

# Let's define what it means to be approved by a director, DevOps amd Security.
director_approval {
	"Director" in approvals[_].session.teams
}

devops_approval {
	"DevOps" in approvals[_].session.teams
}

security_approval {
	"Security" in approvals[_].session.teams
}

# Approve when a single director approves:
approve {
	director_approval
}

# Approve when both DevOps and Security approve:
approve {
	devops_approval
	security_approval
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
