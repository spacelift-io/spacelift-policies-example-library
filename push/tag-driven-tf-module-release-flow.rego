package spacelift

# When attached to a module, this policy will trigger a tracked run when a tag event is detected.
# It then parses the tag event data and uses that value for the module version.
# Here, we remove a git tag prefixed with "v" as the Terraform Module Registry only supports versions in a numeric "X.X.X" format.

module_version := version {
	version := trim_prefix(input.push.tag, "v")
}

track {
	input.push.tag != ""
}

propose = true

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
