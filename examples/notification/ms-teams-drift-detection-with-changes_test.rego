package spacelift

test_drift_detected_with_changes {
	webhook[payload] with input as {
		"account": {"name": "test-account"},
		"webhook_endpoints": [{"id": "teams-webhook"}],
		"run_updated": {
			"stack": {"id": "test-stack", "name": "Test Stack"},
			"run": {
				"id": "test-run",
				"state": "FINISHED",
				"drift_detection": true,
				"changes": [{"action": "added"}],
			},
		},
	}

	payload.endpoint_id == "teams-webhook"
	payload.payload.attachments[0].content.body[0].text == "🔄 Drift Detected"
}

test_no_drift_no_webhook {
	not webhook[_] with input as {
		"account": {"name": "test-account"},
		"webhook_endpoints": [{"id": "teams-webhook"}],
		"run_updated": {
			"stack": {"id": "test-stack", "name": "Test Stack"},
			"run": {
				"id": "test-run",
				"state": "FINISHED",
				"drift_detection": false,
				"changes": [{"action": "added"}],
			},
		},
	}
}

test_drift_no_changes_no_webhook {
	not webhook[_] with input as {
		"account": {"name": "test-account"},
		"webhook_endpoints": [{"id": "teams-webhook"}],
		"run_updated": {
			"stack": {"id": "test-stack", "name": "Test Stack"},
			"run": {
				"id": "test-run",
				"state": "FINISHED",
				"drift_detection": true,
				"changes": [],
			},
		},
	}
}
