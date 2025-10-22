package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# The push policy can be used to have the new run pre-empt any runs that are
# currently in progress. The input document includes the in_progress key, which
# contains an array of runs that are currently either still queued or are awaiting
# human confirmation. You can use it in conjunction with the cancel rule like this:
cancel contains run.id if {
	run := input.in_progress[_]
	run.type == "PROPOSED"
	run.state == "QUEUED"
	run.branch == input.pull_request.head.branch
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
