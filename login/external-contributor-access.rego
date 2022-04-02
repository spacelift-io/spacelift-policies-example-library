package spacelift

# NOTE: This feature is not available when using single sign-on - 
# your identity provider must be able to successfully validate each user 
# trying to log in to Spacelift.

# Sometimes you have folks (short-term consultants, most likely) who are 
# not members of your organization but need access to your Spacelift account -
# either as regular members or perhaps even as admins. There's also the situation
# where a bunch of friends is working on a hobby project in a personal GitHub account
# and they could use access to Spacelift. Here's an example of a policy that allows
# a bunch of allow-listed folks to get regular access and one to get admin privileges:

admins  := { "alice" }
allowed := { "bob", "charlie", "danny" }
login   := input.session.login

admin { admins[login] }
allow { allowed[login] }
deny  { not admins[login]; not allowed[login] }

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample { true }
