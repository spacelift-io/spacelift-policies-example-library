package spacelift

import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Define what commands are allowed
allowlist := ["ls", "ps"]

# Approve when not a task.
approve if {
	input.run.type != "TASK"
}

# Approve when allowlisted.
approve if {
	some input.run.command in allowlist
}

# Approve with two or more approvals.
approve if {
	count(input.reviews.current.approvals) > 1
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
