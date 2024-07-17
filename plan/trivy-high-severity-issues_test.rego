package spacelift

# Test case for warning when trivy encountered misconfingurations detected some issues, the count has exceeded the threshold.
test_high_severity_warnings_are_generated {
	warn["Warning due to high severity misconfiguration: Instance with unencrypted block device."] with input as {"third_party_metadata": {"custom": {"trivy": {"Results": [
		{"Misconfigurations": [
			{
				"Severity": "HIGH",
				"Status": "FAIL",
				"Title": "Instance with unencrypted block device.",
			},
			{
				"Severity": "MEDIUM",
				"Status": "FAIL",
				"Title": "Some other misconfiguration.",
			},
		]},
		{"Misconfigurations": [{
			"Severity": "HIGH",
			"Status": "FAIL",
			"Title": "Instance does not require IMDS access to require a token",
		}]},
	]}}}}
	warn["Warning due to high severity misconfiguration: Instance does not require IMDS access to require a token"] with input as {"third_party_metadata": {"custom": {"trivy": {"Results": [
		{"Misconfigurations": [
			{
				"Severity": "HIGH",
				"Status": "FAIL",
				"Title": "Instance with unencrypted block device.",
			},
			{
				"Severity": "MEDIUM",
				"Status": "FAIL",
				"Title": "Some other misconfiguration.",
			},
		]},
		{"Misconfigurations": [{
			"Severity": "HIGH",
			"Status": "FAIL",
			"Title": "Instance does not require IMDS access to require a token",
		}]},
	]}}}}
}
