package spacelift_test

import data.spacelift
import rego.v1

test_warn_on_destroy_run_with_resource_count if {
	spacelift.warn["Destroy runs require manual confirmation (2 resources to destroy)"] with input as {
		"spacelift": {"run": {"type": "DESTROY"}},
		"terraform": {"resource_changes": [
			{"address": "aws_s3_bucket.logs", "change": {"actions": ["delete"]}},
			{"address": "aws_iam_role.app", "change": {"actions": ["delete"]}},
			{"address": "aws_instance.legacy", "change": {"actions": ["forget"]}},
			{"address": "data.aws_caller_identity.current", "change": {"actions": ["read"]}},
		]},
	}
}

test_warn_on_destroy_run_without_changes if {
	spacelift.warn["Destroy runs require manual confirmation (0 resources to destroy)"] with input as {"spacelift": {"run": {"type": "DESTROY"}}}
}

test_no_warning_on_tracked_run if {
	count(spacelift.warn) == 0 with input as {
		"spacelift": {"run": {"type": "TRACKED"}},
		"terraform": {"resource_changes": [{"address": "aws_s3_bucket.logs", "change": {"actions": ["delete"]}}]},
	}
}

test_no_warning_on_proposed_run if {
	count(spacelift.warn) == 0 with input as {"spacelift": {"run": {"type": "PROPOSED"}}}
}

test_no_warning_without_run if {
	count(spacelift.warn) == 0 with input as {}
}
