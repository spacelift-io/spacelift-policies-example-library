package spacelift

# This rule will generate an array of Slack channel names from the stack labels.
slack_channels[slack_channel] {
	# Extract labels from the stack
	label := input.run_updated.stack.labels[_]

	# Check if the label starts with "slack:"
	startswith(label, "slack:")

	# Extract the actual channel name after "slack:"
	slack_channel := split(label, ":")[1]
}

slack[{"channel_id": channel}] {
	run := input.run_updated.run
	run.type == "TRACKED"

	# Here we're using the slack_channels rule to get all channels 
	# and iterate over each one.
	channel = slack_channels[_]
}

sample = true
