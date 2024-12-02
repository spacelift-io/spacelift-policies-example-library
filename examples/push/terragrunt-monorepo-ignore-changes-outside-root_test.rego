package spacelift_test

import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Test tracking behavior
test_track_valid_push if {
	input := {
		"push": {
			"branch": "main",
			"affected_files": ["project-root/main.tf"],
		},
		"stack": {
			"branch": "main",
			"project_root": "project-root/",
		},
	}
	spacelift.track with input as input
}

# Test proposing behavior
test_propose_valid_push if {
	input := {
		"push": {
			"branch": "feature",
			"affected_files": ["project-root/feature.tf"],
		},
		"stack": {
			"branch": "main",
			"project_root": "project-root/",
		},
	}
	spacelift.propose with input as input
}

# Test ignoring behavior due to unaffected files
test_ignore_unaffected_push if {
	input := {
		"push": {
			"branch": "main",
			"affected_files": ["unrelated-folder/unrelated-file.txt"],
		},
		"stack": {
			"branch": "main",
			"project_root": "project-root/",
		},
	}
	spacelift.ignore with input as input
}

# Test ignoring behavior due to tag push
test_ignore_tag_push if {
	input := {
		"push": {
			"tag": "v1.0.0",
			"affected_files": ["project-root/main.tf"],
		},
		"stack": {
			"branch": "main",
			"project_root": "project-root/",
		},
	}
	spacelift.ignore with input as input
}
