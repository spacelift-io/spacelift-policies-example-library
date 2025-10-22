package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# NOTE: This feature is not available when using single sign-on -
# your identity provider must be able to successfully validate each user
# trying to log in to Spacelift.

# Sometimes you have folks (short-term consultants, most likely) who are
# not members of your organization but need access to your Spacelift account -
# either as regular members or perhaps even as admins. There's also the situation
# where a bunch of friends is working on a hobby project in a personal GitHub account
# and they could use access to Spacelift. Here's an example of a policy that allows
# a bunch of allow-listed folks to get regular access and one to get admin privileges:

admins := {"alice"}

allowed := {"bob", "charlie", "danny"}

login := input.session.login

admin if {
	admins[login]
}

allow if {
	allowed[login]
}

deny if {
	not admins[login]
	not allowed[login]
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
