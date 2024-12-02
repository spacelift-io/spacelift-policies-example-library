package spacelift

# Test case for drift reconciliation runs requiring manual approval
test_warn_drift_reconciliation_runs_requires_manual_approval {
	warn["Drift reconciliation requires manual approval"] with input as {"spacelift": {"run": {
		"drift_detection": true,
		"type": "TRACKED",
	}}}
}

# Test case for non drift reconciliation requiring manual approval
test_non_drift_reconciliation_runs_require_no_manual_approval {
	count(warn) == 0 with input as {"spacelift": {"run": {
		"drift_detection": false,
		"type": "TRACKED",
	}}}
}
