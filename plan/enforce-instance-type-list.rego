package spacelift

# Smart Sanitization should be enabled on the stack so the policy can correctly read
# the instance type.

# Define the deny list of instance types
deny_list := ["t2.2xlarge", "t2.xlarge"]

# Define the allow list of instance types
allow_list := ["t2.nano", "t2.micro", "t2.small"]

# Deny if the instance type is in the deny list
deny[sprintf(message, [resource.address, instance])] {
	message := "Instance type %s is not allowed (%s)"
	resource := input.terraform.resource_changes[_]
	resource.type == "aws_instance"
	instance := resource.change.after.instance_type
	is_in_deny_list(instance)
}

# Warn if the instance type is not in the allow or deny lists
warn[sprintf(message, [resource.address, instance])] {
	message := "Instance type %s is not recommended (%s)"
	resource := input.terraform.resource_changes[_]
	resource.type == "aws_instance"
	instance := resource.change.after.instance_type
	not is_in_allow_list(instance)
	not is_in_deny_list(instance)
}

# Helper function to check if instance type is in the allow list
is_in_allow_list(instance) {
	some allowed_instance
	allowed_instance = allow_list[_]
	allowed_instance == instance
}

# Helper function to check if instance type is in the deny list
is_in_deny_list(instance) {
	some denied_instance
	denied_instance = deny_list[_]
	denied_instance == instance
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
