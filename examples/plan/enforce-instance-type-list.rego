package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Smart Sanitization should be enabled on the stack so the policy can correctly read
# the instance type.

# Define the deny list of instance types
deny_list := {"t2.2xlarge", "t2.xlarge"}

# Define the allow list of instance types
allow_list := {"t2.nano", "t2.micro", "t2.small"}

# Deny if the instance type is in the deny list
deny contains sprintf(message, [resource.address, instance]) if {
	message := "Instance type %s is not allowed (%s)"
	resource := input.terraform.resource_changes[_]
	resource.type == "aws_instance"
	instance := resource.change.after.instance_type
	deny_list[instance]
}

# Warn if the instance type is not in the allow or deny lists
warn contains sprintf(message, [resource.address, instance]) if {
	message := "Instance type %s is not recommended (%s)"
	resource := input.terraform.resource_changes[_]
	resource.type == "aws_instance"
	instance := resource.change.after.instance_type
	not allow_list[instance]
	not deny_list[instance]
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
