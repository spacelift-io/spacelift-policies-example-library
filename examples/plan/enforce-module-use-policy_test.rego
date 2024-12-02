package spacelift

# Test case for denying creation of controlled resource type.
test_deny_creation_of_controlled_resource_type {
	deny["Resource 'aws_s3_bucket.bucket_1' cannot be created directly. Module(s) 'terraform-aws-modules/s3-bucket/aws' must be used instead"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_s3_bucket.bucket_1",
		"type": "aws_s3_bucket",
		"change": {"actions": ["create"]},
	}]}}
}

# Test case for update creation of controlled resource type.
test_deny_update_of_controlled_resource_type {
	deny["Resource 'aws_s3_bucket.bucket_1' cannot be created directly. Module(s) 'terraform-aws-modules/s3-bucket/aws' must be used instead"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_s3_bucket.bucket_1",
		"type": "aws_s3_bucket",
		"change": {"actions": ["update"]},
	}]}}
}

# Test case for allowing deletion of controlled resource type.
test_allow_deletion_of_controlled_resource_type {
	count(deny) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "aws_s3_bucket.bucket_1",
		"type": "aws_s3_bucket",
		"change": {"actions": ["delete"]},
	}]}}
}

# Test case for allowing creation of uncontrolled resource type.
test_allow_creation_of_uncontrolled_resource_type {
	count(deny) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "aws_ecs_cluster.one",
		"type": "aws_ecs_cluster",
		"change": {"actions": ["create"]},
	}]}}
}
