package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy approves any runs when someone from Security team approves the changes to the resources in the list,
# and rejects any runs when someone from other teams tries to approve the changes.

# This policy can be combined with automatic policy attachment (https://docs.spacelift.io/concepts/policy#automatically)
# to automatically enforce it across stacks.

approve if {
	input.run.state != "UNCONFIRMED"
}

approval_list := [
	"aws_iam_access_key",
	"aws_security_group",
	"aws_security_group_rule",
	"aws_network_acl",
	"aws_iam_policy",
	"aws_iam_role",
	"aws_iam_user_policy",
]

requires_approval if {
	# Loop over each resource change in the plan
	resource := input.run.changes[_]

	# Check if any of the actions on the resource is "added"
	action := resource.actions[_]
	action == "added"
	resource.entity.type == approval_list[_]
}

requires_approval if {
	# Loop over each resource change in the plan
	resource := input.run.changes[_]

	# Check if any of the actions on the resource is "changed"
	action := resource.actions[_]
	action == "changed"
	resource.entity.type == approval_list[_]
}

requires_approval if {
	# Loop over each resource change in the plan
	resource := input.run.changes[_]

	# Check if any of the actions on the resource is "deleted"
	action := resource.actions[_]
	action == "deleted"
	resource.entity.type == approval_list[_]
}

approvals := input.reviews.current.approvals

# Let's define what it means to be approved by Security team.
security_approval if {
	"Security" in approvals[_].session.teams
}

# Approve when Security team approve and Require at least 1 approval:
approve if {
	security_approval
	count(input.reviews.current.approvals) > 0
}

# Require at least 1 rejection
reject if {
	count(input.reviews.current.rejections) > 0
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
