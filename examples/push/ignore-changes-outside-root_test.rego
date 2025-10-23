package spacelift_test

import data.spacelift
import rego.v1

test_affected_no_files if {
	not spacelift.affected with input as {
		"stack": {"project_root": ""},
		"push": {"affected_files": []},
	}
}

test_affected_tf_files if {
	spacelift.affected with input as {
		"stack": {"project_root": ""},
		"push": {"affected_files": ["main.tf", "stacks.tf"]},
	}
}

test_affected_no_tf_files if {
	not spacelift.affected with input as {
		"stack": {"project_root": ""},
		"push": {"affected_files": ["README", "myicon.png"]},
	}
}

test_affected_outside_project_root if {
	not spacelift.affected with input as {
		"stack": {"project_root": "stacks/my-stack"},
		"push": {"affected_files": ["stacks/another-stack/main.tf"]},
	}
}

test_ignore_affected if {
	spacelift.ignore with spacelift.affected as false
}

test_ignore_not_affected if {
	not spacelift.ignore with spacelift.affected as true
}

test_ignore_tag if {
	spacelift.ignore with input as {"push": {"tag": "v1.0.0"}}
		with spacelift.affected as true
}

test_propose_affected if {
	spacelift.propose with spacelift.affected as true
}

test_propose_not_affected if {
	not spacelift.propose with spacelift.affected as false
}

matching_branch_input := {
	"push": {"branch": "main"},
	"stack": {"branch": "main"},
}

test_track_affected if {
	spacelift.track with input as matching_branch_input with spacelift.affected as true
}

test_track_not_affected if {
	not spacelift.track with input as matching_branch_input with spacelift.affected as false
}

test_track_not_stack_branch if {
	not spacelift.track with input as {
		"push": {"branch": "my-feature"},
		"stack": {"branch": "main"},
	}
		with spacelift.affected as true
}
