package spacelift

# Test when drift detection is present and there's at least one change
test_slack_trigger_for_drift_and_changes {
	input := {"run_updated": {"run": {
		"drift_detection": true,
		"changes": [{"change": "example_change_1"}],
	}}}
	count(slack) == 1 with input as input
}

# Test when drift detection is not present but there's at least one change
test_no_slack_trigger_for_no_drift_but_changes {
	input := {"run_updated": {"run": {
		"drift_detection": false,
		"changes": [{"change": "example_change_1"}],
	}}}
	count(slack) == 0 with input as input
}

# Test when drift detection is present but there are no changes
test_no_slack_trigger_for_drift_but_no_changes {
	input := {"run_updated": {"run": {
		"drift_detection": true,
		"changes": [],
	}}}
	count(slack) == 0 with input as input
}

# Test when both drift detection isn't present and there are no changes
test_no_slack_trigger_for_no_drift_and_no_changes {
	input := {"run_updated": {"run": {
		"drift_detection": false,
		"changes": [],
	}}}
	count(slack) == 0 with input as input
}
