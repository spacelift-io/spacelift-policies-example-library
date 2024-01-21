package spacelift

import future.keywords

# This example trigger policy will cause every stack that declares dependency on
# the current one to get triggered when the current one is successfully updated.
#
# You can read more about trigger policies here:
# https://docs.spacelift.io/concepts/policy/trigger-policy

trigger contains stack.id if {
	some stack in input.stacks
	input.run.state == "FINISHED"
	some label in stack.labels
	label == concat("", ["depends-on:", input.stack.id])
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
