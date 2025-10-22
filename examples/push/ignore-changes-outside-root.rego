package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

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

# Here's a definition of an affected file - its path must both:
# a) start with the Stack's project root, and;
# b) end with ".tf", indicating that it's a Terraform source file;
affected if {
	filepath := input.push.affected_files[_]

	startswith(filepath, input.stack.project_root)
	endswith(filepath, ".tf")
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
