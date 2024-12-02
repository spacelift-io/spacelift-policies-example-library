package spacelift

# Test that the policy requires approval for changes to specified resources
test_requires_approval_resource_changes {
	requires_approval with input as {"run": {"changes": [{
		"actions": ["added"],
		"entity": {"type": "aws_iam_access_key"},
	}]}}
}

# Test approval for security team
test_approve_security_team {
	approve with input as {"reviews": {"current": {"approvals": [{"session": {"teams": ["Security"]}}]}}}
}

# Test rejection for non-security team
test_reject_non_security_team {
	not approve with input as {"reviews": {"current": {"approvals": [{"session": {"teams": ["Development"]}}]}}}
}

# Test that reject works when someone from a non-security team tries to approve
test_reject_works {
	reject with input as {"reviews": {"current": {"rejections": [1]}}}
}
