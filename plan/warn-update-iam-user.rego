package spacelift

# This policy is a plan policy, it will validate the resources during the plan phase.
# More details at: https://docs.spacelift.io/concepts/policy/terraform-plan-policy

warn[sprintf(message, [resource.address, action])] {
  message := "resource: %s action %s requires human review"

  # Review actions include "update" and "delete"

  review := {"delete", "update"} 
  resource := input.terraform.resource_changes[_]
  action := resource.change.actions[_]
  review[action]

  # Check if the resource type is an IAM user
  resource.type == "aws_iam_user"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample {true}