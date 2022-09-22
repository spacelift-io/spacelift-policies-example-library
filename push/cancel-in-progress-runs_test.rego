package spacelift

test_cancel_runs_allowed {
	cancel.test with input as {
		"pull_request": {"head": {"branch": "main"}},
		"in_progress": [{
			"id": "test",
			"type": "PROPOSED",
			"state": "QUEUED",
			"branch": "main",
		}],
	}
}

test_cancel_runs_denied {
	not cancel.test with input as {
		"pull_request": {"head": {"branch": "feature/example"}},
		"in_progress": [{
			"id": "test",
			"type": "PROPOSED",
			"state": "QUEUED",
			"branch": "main",
		}],
	}
}
