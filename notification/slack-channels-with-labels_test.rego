package spacelift

# 1. Label with the right format triggers slack rule
test_single_label_triggers_slack {
	result := slack with input as {"run_updated": {
		"stack": {"labels": ["slack:C12345678"]},
		"run": {"type": "TRACKED"},
	}}
	count(result) == 1
	result[_] == {"channel_id": "C12345678"}
}

# 2. Two labels in the right format should trigger slack rule twice
test_two_labels_trigger_slack_twice {
	result := slack with input as {"run_updated": {
		"stack": {"labels": [
			"slack:C12345678",
			"slack:C89101112",
		]},
		"run": {"type": "TRACKED"},
	}}
	count(result) == 2
	result[_] == {"channel_id": "C12345678"}
	result[_] == {"channel_id": "C89101112"}
}

# 3. Label not in the right format should not trigger slack rule
test_wrong_format_doesnt_trigger_slack {
	result := slack with input as {"run_updated": {
		"stack": {"labels": ["slackXYZ:C12345678"]},
		"run": {"type": "TRACKED"},
	}}
	count(result) == 0
}
