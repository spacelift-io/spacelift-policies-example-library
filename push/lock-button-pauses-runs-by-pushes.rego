package spacelift

#This is the default push policy with the condition that the locked button cannot be set by anyone.

track {
	affected
	input.push.branch == input.stack.branch
	input.stack.locked_by == null
}

propose {
	affected
	input.push.branch != ""
	input.stack.locked_by == null
}

ignore {
	input.push.branch == ""
}

affected {
	strings.any_prefix_match(input.push.affected_files, input.stack.project_root)
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
