package spacelift

webhook[wbdata] {
	# 1. Identify the specific webhook
	endpoint := input.webhook_endpoints[_]
	endpoint.id == "teams-webhook"

	# 2. Logic: Only trigger if drift is detected and there are changes
	input.run_updated.run.drift_detection
	count(input.run_updated.run.changes) > 0

	# 3. Helpers for readability
	stack := input.run_updated.stack
	run := input.run_updated.run

	# 4. Construct the payload
	wbdata := {
		"endpoint_id": endpoint.id,
		"payload": {
			"type": "message",
			"attachments": [{
				"contentType": "application/vnd.microsoft.card.adaptive",
				"content": {
					"$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
					"type": "AdaptiveCard",
					"version": "1.2",
					"body": [
						{
							"type": "TextBlock",
							"size": "Large",
							"weight": "Bolder",
							"text": "🔄 Drift Detected",
							"wrap": true,
						},
						{
							"type": "FactSet",
							"facts": [
								{"title": "Stack", "value": stack.name},
								{"title": "State", "value": run.state},
								{"title": "Changes", "value": sprintf("%d resource(s)", [count(run.changes)])},
							],
						},
					],
					"actions": [{
						"type": "Action.OpenUrl",
						"title": "View in Spacelift",
						"url": sprintf("https://%s.app.spacelift.io/stack/%s/run/%s", [input.account.name, stack.id, run.id]),
					}],
				},
			}],
		},
	}
}

sample := true
