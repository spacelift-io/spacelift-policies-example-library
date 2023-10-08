package spacelift

# Mocked Data for Tests
mock_push_affected := {"affected_files": ["tracked/file.txt", "untracked/file.txt"]}

mock_push_not_affected := {"affected_files": ["not_affected/file.txt"]}

mock_stack_labels_with_trackings := {"labels": ["trackeddirectories:tracked", "trackedextensions:.txt"]}

# Tests

# Test: track rule with different branches
test_track_different_branches {
	input := {
		"push": {"branch": "main"},
		"stack": {"branch": "develop"},
	}
	not track with input as input
}

# Test: propose rule with non-empty branch
test_propose_non_empty_branch {
	input := {
		"push": {"branch": "main"},
		"stack": {},
	}
	propose with input as input
}

# Test: propose rule with empty branch
test_propose_empty_branch {
	input := {
		"push": {"branch": ""},
		"stack": {},
	}
	not propose with input as input
}

# Test: affected by directory path
test_affected_directory {
	input := {
		"push": mock_push_affected,
		"stack": mock_stack_labels_with_trackings,
	}
	affected with input as input
}

# Test: affected by file extension
test_affected_extension {
	input := {
		"push": mock_push_affected,
		"stack": mock_stack_labels_with_trackings,
	}
	affected with input as input
}

# Test: not track by directory path
test_not_affected_directory {
	input := {
		"push": mock_push_not_affected,
		"stack": mock_stack_labels_with_trackings,
	}
	not track with input as input
}

# Test: not track by file extension
test_not_affected_extension {
	input := {
		"push": mock_push_not_affected,
		"stack": mock_stack_labels_with_trackings,
	}
	not track with input as input
}

# Test: track rule with not affected files
test_ignore_not_affected {
	input := {
		"push": mock_push_not_affected,
		"stack": mock_stack_labels_with_trackings,
	}
	not track with input as input
}
