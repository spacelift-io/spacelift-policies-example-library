package spacelift

import future.keywords.contains
import future.keywords.if
import future.keywords.in

# This example Git push policy ignores all changes that are outside a project's
# root. Other than that, it follows the defaults - pushes to the tracked branch
# trigger tracked runs, pushes to all other branches trigger proposed runs, tag
# pushes are ignored.
#
# You can read more about push policies here:
# https://docs.spacelift.io/concepts/policy/git-push-policy

track if {
	affected
	input.push.branch == input.stack.branch
}

propose if {
	affected
}

ignore if {
	not affected
}

ignore if {
	input.push.tag != ""
}

# Here's a definition of an affected file - its path must:
# a) start with the Stack's project root, and;
# b) end with ".tf", indicating that it's a Terraform source file;
affected if {
	some filepath in input.push.affected_files

	startswith(filepath, input.stack.project_root)
	endswith(filepath, ".tf")
}

# OR

# a) start with the Stack's project root, and;
# b) end with ".hcl", indicating that it's a Terraform source file;
affected if {
	some filepath in input.push.affected_files

	startswith(filepath, input.stack.project_root)
	endswith(filepath, ".hcl")
}

# OR

# a) start with the Stack's project root, and;
# b) end with ".rego", indicating that it's a rego policy file;
affected if {
	some filepath in input.push.affected_files

	startswith(filepath, input.stack.project_root)
	endswith(filepath, ".rego")
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
