package spacelift

# First, let's define all conditions that require explicit
# user approval.
requires_approval {
	input.run.state == "UNCONFIRMED"
}

requires_approval {
	input.run.type == "TASK"
}

# Then, let's automatically approve all other jobs.
approve {
	not requires_approval
}

# Autoapprove some task commands. Note how we don't check for run type
# because only tasks will the have "command" field set.
task_allowlist := ["ls", "ps"]

approve {
	input.run.command == task_allowlist[_]
}

# Two approvals and no rejections to approve.
approve {
	count(input.reviews.current.approvals) > 1
	count(input.reviews.current.rejections) == 0
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
