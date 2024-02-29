package spacelift

# Test case for warning when tfsec detected some issues, the count has exceeded the threshold.
test_warning_when_there_are_some_issues_below_threshold {
	warn["You have a couple of high serverity issues: 4"] with input as {"third_party_metadata": {"custom": {"tfsec": {"results": [
		{
			"severity": "HIGH",
			"test": 1,
		},
		{
			"severity": "HIGH",
			"test": 2,
		},
		{
			"severity": "HIGH",
			"test": 3,
		},
		{
			"severity": "HIGH",
			"test": 4,
		},
	]}}}}
}
