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

# Then, let's automatically approve all other jobs.
approve if {
	not requires_approval
}

# Autoapprove some task commands. Note how we don't check for run type
# because only tasks will the have "command" field set.
task_allowlist := ["ls", "ps"]

approve if {
	input.run.command == task_allowlist[_]
}

# Two approvals and no rejections to approve.
approve if {
	count(input.reviews.current.approvals) > 1
	count(input.reviews.current.rejections) == 0
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
