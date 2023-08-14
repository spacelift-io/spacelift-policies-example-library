package spacelift

# Test case for an aws_s3_bucket being deleted
test_deny_s3_bucket_deletion {
    # Provide mock input data
    input := {
        "terraform": {
            "resource_changes": [
                {
                    "address": "aws_s3_bucket.my_bucket",
                    "type": "aws_s3_bucket",
                    "change": {
                        "actions": ["delete"]
                    }
                }
            ]
        }
    }

    # Assert deny rule fires with the expected message
    deny[msg] with input as input
    msg == "do not delete aws_s3_bucket.my_bucket"
}

# Test case for an aws_instance being deleted (which should not be denied)
test_allow_instance_deletion {
    # Provide mock input data
    input := {
        "terraform": {
            "resource_changes": [
                {
                    "address": "aws_instance.my_instance",
                    "type": "aws_instance",
                    "change": {
                        "actions": ["delete"]
                    }
                }
            ]
        }
    }

    # Assert deny rule does not fire
    count(deny) == 0 with input as input
}