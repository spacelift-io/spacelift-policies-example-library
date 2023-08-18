package spacelift

# This policy is a plan policy, it will validate the resources during the plan phase.
# More details at: https://docs.spacelift.io/concepts/policy/terraform-plan-policy
# The "deny" rule fires when a specified resource is being deleted.
# The result is a formatted message with the address of the offending resource.

deny[sprintf(message, [resource.address])] {
	# Define the error message format
	message := "do not delete %s"

	# Loop over each resource change in the plan
	resource := input.terraform.resource_changes[_]

	# Define a set of resource types for which deletions should be prevented.
	prevent_delete := {
		"aws_db_instance",
		"aws_efs_file_system",
		"aws_dynamodb_table",
		"aws_s3_bucket",
	}

	# Check if the resource type is one of those defined in prevent_delete
	prevent_delete[resource.type]

	# Check if any of the actions on the resource is "delete"
	resource.change.actions[_] == "delete"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
