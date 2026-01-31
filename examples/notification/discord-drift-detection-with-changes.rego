package spacelift

# Send updates about tracked runs to discord.
webhook[wbdata] {
	# 1. Identify the specific webhook
	endpoint := input.webhook_endpoints[_]
	endpoint.id == "discord-webhook" # Change this to your discord webhook ID

	# 2. Extract stack and run info
	stack := input.run_updated.stack
	run := input.run_updated.run

	# 3. Construct the payload
	wbdata := {
		"endpoint_id": endpoint.id,
		"payload": {
			"embeds": [{
				"title": "Drift detected!",
                # change your URL below to app.us.spacelift.io if you are using the US region or app.eu.spacelift.io if you are using the EU region
				"description": sprintf("Stack: [%s](https://%s.app.spacelift.io/stack/%s)\nRun ID: [%s](https://%s.app.spacelift.io/stack/%s/run/%s)\nRun state: %s", [stack.name, input.account.name, stack.id, run.id, input.account.name, stack.id, run.id, run.state]),
			}],
		},
	}

	# 4. Trigger logic: ONLY if drift is detected with more than 0 changes
	input.run_updated.run.drift_detection
	count(input.run_updated.run.changes) > 0
}

sample := true
