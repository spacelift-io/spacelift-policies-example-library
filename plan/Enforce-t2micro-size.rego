package spacelift

# This policy is a plan policy, it will validate the resources during the plan phase.
# More details at: https://docs.spacelift.io/concepts/policy/terraform-plan-policy

deny[sprintf(message, [resource.address, instance])] {
    # Define the error message format
    message := "Instance size incorrect, please use t2.micro (%s)"

    # Loop over each resource change in the plan
    resource := input.terraform.resource_changes[_]

    # Only apply the policy to AWS instances
    resource.type == "aws_instance"

    # Extract the instance type from the resource's after-change state
    instance := resource.change.after.instance_type

    # If the instance type is not "t2.micro", then deny the action
    instance != sanitized("t2.micro")
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample { true }