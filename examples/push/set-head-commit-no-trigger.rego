package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy sets the head commit but does not trigger a tracked run.
# This is helpful when the tracked run gets triggered from elsewhere.
# See https://docs.spacelift.io/concepts/policy/git-push-policy#corner-case-track-dont-trigger

track if {
	input.push.branch == input.stack.branch
}

propose if {
	not track
}

notrigger := true

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
