package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy will cause every stack that declares dependency on the current stack
# and state to get triggered when the conditions are met.
#
# You can read more about trigger policies here:
# https://docs.spacelift.io/concepts/policy/trigger-policy

trigger contains stack.id if {
	input.run.type == "TRACKED"
	some stack in input.stacks
	some label in stack.labels
	label == concat("", [
		"depends-on:", input.stack.id,
		"|state:", input.run.state,
	])
}
