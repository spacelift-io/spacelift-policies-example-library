package spacelift

# Mocked Data for Tests
mock_push_affected := {"affected_files": ["tracked/file.txt", "untracked/file.txt"]}

mock_push_not_affected := {"affected_files": ["not_affected/file.txt"]}

mock_stack_labels_with_trackings := {"labels": ["trackeddirectories:tracked", "trackedextensions:.txt"]}

# Tests

# Test: track rule with different branches
test_track_different_branches {
	not track with input as {
		"push": {"branch": "main"},
		"stack": {"branch": "develop"},
	}
}

# Test: propose rule with non-empty branch
test_propose_non_empty_branch {
	propose with input as {
		"push": {"branch": "main"},
		"stack": {},
	}
}

# Test: propose rule with empty branch
test_propose_empty_branch {
	not propose with input as {
		"push": {"branch": ""},
		"stack": {},
	}
}

# Test: affected by directory path
test_affected_directory {
	affected with input as {
		"push": mock_push_affected,
		"stack": mock_stack_labels_with_trackings,
	}
}

# Test: affected by file extension
test_affected_extension {
	affected with input as {
		"push": mock_push_affected,
		"stack": mock_stack_labels_with_trackings,
	}
}

# Test: not track by directory path
test_not_affected_directory {
	not track with input as {
		"push": mock_push_not_affected,
		"stack": mock_stack_labels_with_trackings,
	}
}

# Test: not track by file extension
test_not_affected_extension {
	not track with input as {
		"push": mock_push_not_affected,
		"stack": mock_stack_labels_with_trackings,
	}
}

# Test: track rule with not affected files
test_ignore_not_affected {
	not track with input as {
		"push": mock_push_not_affected,
		"stack": mock_stack_labels_with_trackings,
	}
}
