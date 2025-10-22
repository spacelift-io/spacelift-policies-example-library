package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This rule will generate an array of Slack channel names from the stack labels.
slack_channels contains slack_channel if {
	# Extract labels from the stack
	label := input.run_updated.stack.labels[_]

	# Check if the label starts with "slack:"
	startswith(label, "slack:")

	# Extract the actual channel name after "slack:"
	slack_channel := split(label, ":")[1]
}

slack contains {"channel_id": channel} if {
	run := input.run_updated.run
	run.type == "TRACKED"

	# Here we're using the slack_channels rule to get all channels
	# and iterate over each one.
	channel = slack_channels[_]
}

sample := true
