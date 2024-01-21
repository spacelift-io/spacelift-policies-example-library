package spacelift

import future.keywords.contains
import future.keywords.if
import future.keywords.is

# This policy will cause every stack that declares dependency on the current stack
# and state to get triggered when the conditions are met.
#
# You can read more about trigger policies here:
# https://docs.spacelift.io/concepts/policy/trigger-policy

trigger contains stack.id if {
	some stack in input.stacks
	input.run.type == "TRACKED"
	some label in stack.labels
	label == concat("", [
		"depends-on:", input.stack.id,
		"|state:", input.run.state,
	])
}
