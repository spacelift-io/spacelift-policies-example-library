package spacelift

# Test case for an aws_s3_bucket being deleted
test_deny_s3_bucket_deletion {
	# Assert deny rule fires with the expected message
	deny["do not delete aws_s3_bucket.my_bucket"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_s3_bucket.my_bucket",
		"type": "aws_s3_bucket",
		"change": {"actions": ["delete"]},
	}]}}
}

# Test case for an aws_db_instance being deleted
test_deny_db_instance_deletion {
	# Assert deny rule fires with the expected message
	deny["do not delete aws_db_instance.my_rds"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_db_instance.my_rds",
		"type": "aws_db_instance",
		"change": {"actions": ["delete"]},
	}]}}
}

# Test case for an aws_efs_file_system being deleted
test_deny_efs_file_system_deletion {
	# Assert deny rule fires with the expected message
	deny["do not delete aws_efs_file_system.my_efs"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_efs_file_system.my_efs",
		"type": "aws_efs_file_system",
		"change": {"actions": ["delete"]},
	}]}}
}

# Test case for an aws_dynamodb_table being deleted
test_deny_dynamodb_table_deletion {
	# Assert deny rule fires with the expected message
	deny["do not delete aws_dynamodb_table.my_table"] with input as {"terraform": {"resource_changes": [{
		"address": "aws_dynamodb_table.my_table",
		"type": "aws_dynamodb_table",
		"change": {"actions": ["delete"]},
	}]}}
}

# Test case for an aws_instance being deleted (which should not be denied)
test_allow_instance_deletion {
	# Assert deny rule does not fire
	count(deny) == 0 with input as {"terraform": {"resource_changes": [{
		"address": "aws_instance.my_instance",
		"type": "aws_instance",
		"change": {"actions": ["delete"]},
	}]}}
}
