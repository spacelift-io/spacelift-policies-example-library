package spacelift_test

import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Test for missing mandatory labels
test_deny_for_missing_mandatory_labels if {
	deny_input := {"entity": {
		"type": "google_storage_bucket",
		"data": {"values": {"labels": {"mandatory1": "your_mandatory1_value"}}},
		# Missing "mandatory2"

	}}
	spacelift.deny with input.spacelift.run.changes as deny_input
}

# Test for unacceptable labels
test_deny_for_unacceptable_labels if {
	deny_unacceptable_labels := {"entity": {
		"type": "google_storage_bucket",
		"data": {"values": {"labels": {
			"mandatory1": "your_mandatory1_value",
			"mandatory2": "your_mandatory2_value",
			"unacceptable_label": "value", # Unacceptable label
		}}},
	}}
	spacelift.deny with input.spacelift.run.changes as deny_unacceptable_labels
}

# Test for resource not in mandatory_resources
test_no_deny_for_non_mandatory_resource if {
	no_deny_resource := {"entity": {
		"type": "non_mandatory_resource",
		"data": {"values": {"labels": {}}},
	}}
	count(spacelift.deny) == 0 with input.spacelift.run.changes as no_deny_resource
}

# Test for correct labels
test_no_deny_for_correct_labels if {
	no_deny_input := {"entity": {
		"type": "google_storage_bucket",
		"data": {"values": {"labels": {
			"mandatory1": "your_mandatory1_value",
			"mandatory2": "your_mandatory2_value",
			"acceptable1": "value",
		}}},
	}}
	count(spacelift.deny) == 0 with input.spacelift.run.changes as no_deny_input
}
