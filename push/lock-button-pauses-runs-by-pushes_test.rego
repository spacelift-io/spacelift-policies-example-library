package spacelift

# Input for locked stack
locked_stack_input = {
	"push": {
		"affected_files": ["main.tf"],
		"branch": "main",
	},
	"stack": {
		"branch": "main",
		"project_root": "",
		"locked_by": "user1",
	},
}

# Input for unlocked stack (as you provided)
unlocked_stack_input = {
	"push": {
		"affected_files": ["main.tf"],
		"branch": "main",
	},
	"stack": {
		"branch": "main",
		"project_root": "",
		"locked_by": null,
	},
}

# Test that propose and track are true for unlocked stack
test_propose_and_track_for_unlocked_stack {
	result_propose_unlocked := propose with input as unlocked_stack_input
	result_track_unlocked := track with input as unlocked_stack_input
}

# Test that propose and track are false for locked stack
test_propose_and_track_for_locked_stack {
	not propose with input as locked_stack_input
	not track with input as locked_stack_input
}
