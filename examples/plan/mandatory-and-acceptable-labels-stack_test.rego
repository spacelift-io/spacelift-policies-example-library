package spacelift_test

import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Test for missing or empty labels
test_deny_with_no_labels if {
	spacelift.deny with input as no_labels_input
}

# Test for missing mandatory labels
test_deny_with_missing_mandatory_labels if {
	spacelift.deny with input as missing_mandatory_labels_input
}

# Test for unacceptable labels
test_deny_with_unacceptable_labels if {
	spacelift.deny with input as unacceptable_labels_input
}

# Test for valid labels (no denial)
test_allow_with_valid_labels if {
	count(spacelift.deny) = 0 with input as valid_labels_input
}

# Define inputs for each test case
no_labels_input := {"spacelift": {"stack": {"id": "test", "labels": []}}}

missing_mandatory_labels_input := {"spacelift": {"stack": {"id": "test", "labels": ["acceptable1"]}}}

unacceptable_labels_input := {"spacelift": {"stack": {"id": "test", "labels": ["mandatory1", "mandatory3", "unacceptable"]}}}

valid_labels_input := {"spacelift": {"stack": {"id": "test", "labels": ["mandatory1", "mandatory2", "acceptable1"]}}}
