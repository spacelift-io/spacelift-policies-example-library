package spacelift

# Define what commands are allowed
allowlist := ["ps", "ls", "rm -rf /"]

# Approve when not a task.
approve {
	input.run.type != "TASK"
}

# Approve when allowlisted.
approve {
	input.run.command == allowlist[_]
}

# Approve with two or more approvals.
approve {
	count(input.reviews.current.approvals) > 1
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
