package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This is the default push policy with the condition that the locked button cannot be set by anyone.

track if {
	affected
	input.push.branch == input.stack.branch
	input.stack.locked_by == null
}

propose if {
	affected
	input.push.branch != ""
	input.stack.locked_by == null
}

ignore if {
	input.push.branch == ""
}

affected if {
	strings.any_prefix_match(input.push.affected_files, input.stack.project_root)
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
