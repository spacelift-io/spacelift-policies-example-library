package spacelift

import future.keywords.if
import future.keywords.in

# This example Git push policy will create proposed runs when it detects
# a pull request label that starts with env:
# You can read more about push policies here:
# https://docs.spacelift.io/concepts/policy/git-push-policy

propose if {
	some label in input.stack.labels
	startswith(label, "env:")
	some pr_label in input.pull_request.labels
	label == pr_label
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
