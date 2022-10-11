package spacelift

# This policy will cause every stack that declares dependency on the current stack
# and state to get triggered when the conditions are met.
#
# You can read more about trigger policies here:
# https://docs.spacelift.io/concepts/policy/trigger-policy

trigger[stack.id] {
	stack := input.stacks[_]
	input.run.type == "TRACKED"
	stack.labels[_] == concat("", [
		"depends-on:", input.stack.id,
		"|state:", input.run.state,
	])
}
