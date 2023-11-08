package spacelift

# This example Git push policy will create proposed runs when it detects
# a pull request label that starts with env:
# You can read more about push policies here:
# https://docs.spacelift.io/concepts/policy/git-push-policy

propose {
	label := input.stack.labels[_]
	startswith(label, "env:")
	pr_label := input.pull_request.labels[_]
	label == pr_label
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
