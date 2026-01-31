package spacelift

test_drift_detected_with_changes_discord {
	webhook[payload] with input as {
		"account": {"name": "test-account"},
		"webhook_endpoints": [{"id": "kals-discord-notifications"}],
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

	payload.endpoint_id == "kals-discord-notifications"
	payload.payload.embeds[0].title == "Drift detected!"
	contains(payload.payload.embeds[0].description, "test-account.app.spacelift.io")
}

test_no_drift_no_discord_webhook {
	not webhook[_] with input as {
		"account": {"name": "test-account"},
		"webhook_endpoints": [{"id": "kals-discord-notifications"}],
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
