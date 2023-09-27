package spacelift

# Test when everything is valid
test_track_valid {
	input := {
		"pull_request": {
			"action": "commented",
			"comment": "/spacelift deploy testStack",
			"action_initiator": "user1",
		},
		"stack": {"id": "testStack"},
	}
	track with input as input
}

# Test for an invalid comment
test_not_track_invalid_comment {
	input := {
		"pull_request": {
			"action": "commented",
			"comment": "/spacelift wrong deploy",
			"action_initiator": "user1",
		},
		"stack": {"id": "testStack"},
	}
	not track with input as input
}

# Test for a non-team member
test_not_track_non_team_member {
	input := {
		"pull_request": {
			"action": "commented",
			"comment": "/spacelift deploy testStack",
			"action_initiator": "unknownUser",
		},
		"stack": {"id": "testStack"},
	}
	not track with input as input
}
