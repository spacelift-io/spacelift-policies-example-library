package spacelift

# By default, runs are not triggered when a forked repository opens a pull request against your repository.
# This is because of a security concern: if let's say your infrastructure is open source, someone forks it,
# implements some unwanted junk in there, then opens a pull request for the original repository,
# it'd run automatically with the prankster's code included.
#
# This policy makes an exception for some trusted users/organizations.
#
# See https://docs.spacelift.io/concepts/policy/git-push-policy#allow-forks

allow_fork {
	valid_owners := {"johnwayne", "microsoft"}
	valid_owners[input.pull_request.head_owner]
}

propose := true

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
