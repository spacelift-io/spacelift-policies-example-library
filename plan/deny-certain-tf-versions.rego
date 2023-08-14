package spacelift

# This policy is a plan policy, it will validate the resources during the plan phase.
# More details at: https://docs.spacelift.io/concepts/policy/terraform-plan-policy
# Define a list of now allowed Terraform versions.

notallowed_versions := ["1.4.1", "1.4.2", "1.4.3"]

# The "deny" rule fires when a blocked Terraform version is used.
# The result is a formatted message with the blocked version.

deny[sprintf("not allowed to use this terraform version (%s)", [terraform_version])] { 

  # Extract the Terraform version from the runtime configuration
  terraform_version := input.terraform.terraform_version 

  # Check if the Terraform version is one of those defined in the notallowed_versions list
  notallowed_versions[_] = terraform_version 
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample {true}