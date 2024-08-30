# regal ignore:use-rego-v1
package spacelift_test

import data.spacelift
import future.keywords

# Test with 1 resource having "create-before-destroy" action with moved false
test_create_before_destroy if {
	input_data := {"run_updated": {
		"run": {
			"changes": [{
				"action": "create-Before-destroy-replaced",
				"entity": {
					"address": "aws_instance.example",
					"data": {"values": {"ami": "ami-12345678"}},
					"entity_type": "resource",
				},
				"moved": false,
			}],
			"commit": {"hash": "COMMIT_HASH_CREATE_BEFORE_DESTROY"},
			"state": "FINISHED",
			"type": "PROPOSED",
		},
		"urls": {"run": "https://example.com/run/02"},
	}}

	result := spacelift.pull_request with input as input_data

	count(result) == 1

	# Get the added resources with the input data applied
	added_resources := spacelift.added with input as input_data

	# Get the deleted resources with the input data applied
	deleted_resources := spacelift.deleted with input as input_data

	# Correct count for added resources
	count(added_resources) == 1

	# Correct count for deleted resources
	count(deleted_resources) == 1
}

# Test with 3 resources with action "added", 2 with moved:false and 1 with moved: true
# regal ignore:rule-length
test_added_and_moved_resources if {
	input_data := {"run_updated": {
		"run": {
			"changes": [
				{
					"action": "added",
					"entity": {
						"address": "aws_instance.example1",
						"data": {"values": {"ami": "ami-12345678"}},
						"entity_type": "resource",
					},
					"moved": false,
				},
				{
					"action": "added",
					"entity": {
						"address": "aws_instance.example2",
						"data": {"values": {"ami": "ami-87654321"}},
						"entity_type": "resource",
					},
					"moved": false,
				},
				{
					"action": "added",
					"entity": {
						"address": "aws_instance.example3",
						"data": {"values": {"ami": "ami-11223344"}},
						"entity_type": "resource",
					},
					"moved": true,
				},
			],
			"commit": {"hash": "COMMIT_HASH_ADDED_AND_MOVED"},
			"state": "FINISHED",
			"type": "PROPOSED",
		},
		"urls": {"run": "https://example.com/run/03"},
	}}

	result := spacelift.pull_request with input as input_data

	count(result) == 1

	# Get the added resources with the input data applied
	added_resources := spacelift.added with input as input_data

	# Get the moved resources with the input data applied
	moved_resources := spacelift.moved with input as input_data

	# Correct count for added resources
	count(added_resources) == 2

	# Correct count for moved resources
	count(moved_resources) == 1
}

# Additional test case 1: Check if changed resources are categorized correctly
test_changed_resources if {
	input_data := {"run_updated": {
		"run": {
			"changes": [{
				"action": "changed",
				"entity": {
					"address": "aws_s3_bucket.example",
					"data": {"values": {
						"bucket": "example-bucket",
						"region": "us-west-1",
					}},
					"entity_type": "resource",
				},
				"moved": false,
			}],
			"commit": {"hash": "COMMIT_HASH_CHANGED"},
			"state": "FINISHED",
			"type": "PROPOSED",
		},
		"urls": {"run": "https://example.com/run/04"},
	}}

	result := spacelift.pull_request with input as input_data

	count(result) == 1

	# Get the changed resources with the input data applied
	changed_resources := spacelift.changed with input as input_data

	# Correct count for changed resources
	count(changed_resources) == 1
}

# Additional test case 2: Check if imported resources are categorized correctly
test_imported_resources if {
	input_data := {"run_updated": {
		"run": {
			"changes": [{
				"action": "import",
				"entity": {
					"address": "aws_s3_bucket.example_imported",
					"data": {"values": {}},
					"entity_type": "resource",
				},
				"moved": false,
			}],
			"commit": {"hash": "COMMIT_HASH_IMPORTED"},
			"state": "FINISHED",
			"type": "PROPOSED",
		},
		"urls": {"run": "https://example.com/run/05"},
	}}

	result := spacelift.pull_request with input as input_data

	count(result) == 1

	# Get the imported resources with the input data applied
	imported_resources := spacelift.imported with input as input_data

	# Correct count for imported resources
	count(imported_resources) == 1
}

# Additional test case 3: Check if moved resources are categorized correctly
test_moved_resources if {
	input_data := {"run_updated": {
		"run": {
			"changes": [{
				"action": "moved",
				"entity": {
					"address": "aws_instance.example_moved",
					"data": {"values": {"ami": "ami-99887766"}},
					"entity_type": "resource",
				},
				"moved": true,
			}],
			"commit": {"hash": "COMMIT_HASH_MOVED"},
			"state": "FINISHED",
			"type": "PROPOSED",
		},
		"urls": {"run": "https://example.com/run/06"},
	}}

	result := spacelift.pull_request with input as input_data

	count(result) == 1

	# Get the moved resources with the input data applied
	moved_resources := spacelift.moved with input as input_data

	# Correct count for moved resources
	count(moved_resources) == 1
}

# Additional test case 4: Check if forgotten resources are categorized correctly
test_forgotten_resources if {
	input_data := {"run_updated": {
		"run": {
			"changes": [{
				"action": "forget",
				"entity": {
					"address": "random_pet.example_forget",
					"data": {"values": {}},
					"entity_type": "resource",
				},
				"moved": false,
			}],
			"commit": {"hash": "COMMIT_HASH_FORGOTTEN"},
			"state": "FINISHED",
			"type": "PROPOSED",
		},
		"urls": {"run": "https://example.com/run/07"},
	}}

	result := spacelift.pull_request with input as input_data

	count(result) == 1

	# Get the forgotten resources with the input data applied
	forgotten_resources := spacelift.forgotten with input as input_data

	# Correct count for forgotten resources
	count(forgotten_resources) == 1
}
