package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Assuming you have the Slack integration setup, you could
# attach this policy to a given stack, and this would provide
# the Slack Channel "dev-notifications" access to your Spacelift
# stack's data.
#
# NOTE: If you are looking to scope access to individual Slack channels
# you should consider using the channel id, rather than the name, as names can change.
write if {
	input.slack.channel.name = "dev-notifications"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
