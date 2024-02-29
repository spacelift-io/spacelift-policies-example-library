package spacelift

# Test case for warning when terrascan detected some violated policies, but the count is below the threshold.
test_warn_violated_terrascan_policies_below_threshold {
	warn["You have a couple of violated policies: 1"] with input as {"third_party_metadata": {"custom": {"terrascan": {"results": {"scan_summary": {"violated_policies": 1}}}}}}
}

# Test case for warning when terrascan detected no violated policies.
test_no_warning_or_deny_when_there_are_no_violated_terrascan_policies {
	inp := {"third_party_metadata": {"custom": {"terrascan": {"results": {"scan_summary": {}}}}}}
	count(warn) == 0 with input as inp
	count(deny) == 0 with input as inp
}

# Test case for denying when terrascan detected violated policies, the count has exceeded the threshold.
test_deny_violated_terrascan_policies_exceeded_threshold {
	deny["The number of violated policies 3 is higher than the threshold 2"] with input as {"third_party_metadata": {"custom": {"terrascan": {"results": {"scan_summary": {"violated_policies": 3}}}}}}
}
