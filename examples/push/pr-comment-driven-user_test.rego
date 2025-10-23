package spacelift_test

import data.spacelift
import rego.v1

# Test when everything is valid
test_track_valid if {
	spacelift.track with input as {
		"pull_request": {
			"action": "commented",
			"comment": "/spacelift deploy testStack",
			"action_initiator": "user1",
		},
		"stack": {"id": "testStack"},
	}
}

# Test for an invalid comment
test_not_track_invalid_comment if {
	not spacelift.track with input as {
		"pull_request": {
			"action": "commented",
			"comment": "/spacelift wrong deploy",
			"action_initiator": "user1",
		},
		"stack": {"id": "testStack"},
	}
}

# Test for a non-team member
test_not_track_non_team_member if {
	not spacelift.track with input as {
		"pull_request": {
			"action": "commented",
			"comment": "/spacelift deploy testStack",
			"action_initiator": "unknownUser",
		},
		"stack": {"id": "testStack"},
	}
}
