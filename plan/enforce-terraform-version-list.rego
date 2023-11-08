package spacelift

# Define a list of not allowed Terraform versions.
notallowed_versions := ["1.4.1", "1.4.2", "1.4.3"]

# Define a list of allowed Terraform versions.
allowed_versions := ["1.4.4", "1.4.5", "1.5.0"]

# The "deny" rule fires when a blocked Terraform version is used.
# The result is a formatted message with the blocked version.
deny[sprintf("Not allowed to use Terraform version %s. Please consider using one of the following versions: %v", [terraform_version, allowed_versions])] {
	# Extract the Terraform version from the runtime configuration
	terraform_version := input.terraform.terraform_version

	# Check if the Terraform version is one of those defined in the notallowed_versions list
	notallowed_versions[_] = terraform_version
}

# The "warn" rule fires for any other Terraform version.
warn[sprintf("You're using Terraform version %s, which isn't explicitly allowed or denied. Consider using one of the allowed versions: %v", [terraform_version, allowed_versions])] {
	# Extract the Terraform version from the runtime configuration
	terraform_version := input.terraform.terraform_version

	# Ensure the version is neither in the allowed_versions nor in the notallowed_versions
	not is_version_allowed(terraform_version)
	not is_version_notallowed(terraform_version)
}

# Helper rule to check if a version is in the allowed_versions
is_version_allowed(version) {
	allowed_versions[_] = version
}

# Helper rule to check if a version is in the notallowed_versions
is_version_notallowed(version) {
	notallowed_versions[_] = version
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
