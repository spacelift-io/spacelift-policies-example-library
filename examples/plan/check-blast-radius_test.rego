package spacelift

# Test case for blast radius below threshold for tracked run.
test_check_blast_radius_below_threshold_tracked_run {
	inp := {
		"spacelift": {"run": {"type": "TRACKED"}},
		"terraform": {"resource_changes": [{
			"address": "aws_s3_bucket.my_bucket",
			"type": "aws_s3_bucket",
			"change": {"actions": ["delete"]},
		}]},
	}
	count(deny) == 0 with input as inp
	count(warn) == 0 with input as inp
}

# Test case for blast radius below threshold for proposed run.
test_check_blast_radius_below_threshold_proposed_run {
	inp := {
		"spacelift": {"run": {"type": "PROPOSED"}},
		"terraform": {"resource_changes": [{
			"address": "aws_s3_bucket.my_bucket",
			"type": "aws_s3_bucket",
			"change": {"actions": ["delete"]},
		}]},
	}
	count(deny) == 0 with input as inp
	count(warn) == 0 with input as inp
}

# Test case for blast radius threshold exceeded for tracked run.
test_check_blast_radius_threshold_exceeded_tracked_run {
	inp := {
		"spacelift": {"run": {"type": "TRACKED"}},
		"terraform": {"resource_changes": [{
			"address": "aws_ecs_cluster.one",
			"type": "aws_ecs_cluster",
			"change": {"actions": ["delete"]},
		}]},
	}
	warn["change blast radius too high (200/100)"] with input as inp
	count(deny) == 0 with input as inp
}

# Test case for blast radius threshold exceeded for proposed run.
test_check_blast_radius_threshold_exceeded_proposed_run {
	inp := {
		"spacelift": {"run": {"type": "PROPOSED"}},
		"terraform": {"resource_changes": [{
			"address": "aws_ecs_cluster.one",
			"type": "aws_ecs_cluster",
			"change": {"actions": ["delete"]},
		}]},
	}
	deny["change blast radius too high (200/100)"] with input as inp
	count(warn) == 0 with input as inp
}
