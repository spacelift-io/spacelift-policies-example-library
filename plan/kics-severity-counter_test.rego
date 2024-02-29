package spacelift

# Test case for warning with severity counters.
test_warn_severity_counters {
	warn["You have: 1 info issues, 2 low issues, 3 medium issues"] with input as {"third_party_metadata": {"custom": {"kics": {"severity_counters": {
		"INFO": 1,
		"LOW": 2,
		"MEDIUM": 3,
		"HIGH": 0,
	}}}}}
}

# Test case for denying with high severity issues.
test_deny_for_high_severity_issue {
	deny["The number of violated policies 10 is higher than the threshold 0"] with input as {"third_party_metadata": {"custom": {"kics": {"severity_counters": {
		"INFO": 1,
		"LOW": 2,
		"MEDIUM": 3,
		"HIGH": 10,
	}}}}}
}
