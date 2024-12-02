package spacelift

# Test for failed checkov checks.
test_checkov_less_than_10_failed_checks {
	inp := {"third_party_metadata": {"custom": {"checkov": {"results": {"failed_checks": [
		{"check_id": "CKV_AWS_1"},
		{"check_id": "CKV_AWS_2"},
		{"check_id": "CKV_AWS_3"},
		{"check_id": "CKV_AWS_4"},
		{"check_id": "CKV_AWS_5"},
		{"check_id": "CKV_AWS_6"},
		{"check_id": "CKV_AWS_7"},
		{"check_id": "CKV_AWS_8"},
		{"check_id": "CKV_AWS_9"},
	]}}}}}
	warn["You have a couple of failed checks: 9"] with input as inp
}

test_checkov_no_failed_checks {
	count(warn) == 0 with input as {}
}
