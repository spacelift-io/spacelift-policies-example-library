package spacelift

# The best way to use warn and deny rules together depends on your preferred Git workflow.
# We've found short-lived feature branches with Pull Requests to the tracked branch to work relatively well.
# In this scenario, the `type` of the `run` is important - it's _PROPOSED_ for commits to feature branches,
# and _TRACKED_ on commits to the tracked branch. You will probably want at least some of your rules
# to take that into account and use this mechanism to balance comprehensive feedback on Pull Requests
# and flexibility of being able to deploy things that humans deem appropriate.
#
# As a general rule when using plan policies for code review, **deny** when run type is _PROPOSED_
# and **warn** when it is _TRACKED_. Denying tracked runs unconditionally may be a good idea
# for most egregious violations for which you will not consider an exception,
# but when this approach is taken to an extreme it can make your life difficult.
#
# We suggest that you _at most_ **deny** when the run is _PROPOSED_, which will send a failure status to the GitHub commit,
# but will give the reviewer a chance to approve the change nevertheless.
# If you want a human to take another look before those changes go live, either set stack autodeploy to _false_,
# or explicitly **warn** about potential violations. Here's an example of how to reuse the same rule to **deny**
# or **warn** depending on the run type.

proposed := input.spacelift.run.type == "PROPOSED"

deny[reason] {
	proposed
	reason := iam_user_created[_]
}

warn[reason] {
	not proposed
	reason := iam_user_created[_]
}

iam_user_created[sprintf("Do not create IAM users: (%s)", [resource.address])] {
	resource := input.terraform.resource_changes[_]
	resource.change.actions[_] == "create"

	resource.type == "aws_iam_user"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
