package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Sometimes there are folks who really know what they're doing and changes they introduce can get deployed automatically,
# especially if they already went through code review.
#
# This policy allows commits from allowed individuals to be deployed automatically (assumes Stack is set to autodeploy).

warn contains sprintf(message, [author]) if {
	message := "%s is not on the allow list - human review required"
	author := input.spacelift.commit.author
	allowed := {"alice", "bob", "charlie"}

	not allowed[author]
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
