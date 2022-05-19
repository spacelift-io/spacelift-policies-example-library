package spacelift

# NOTE: This feature is not available when using single sign-on -
# your identity provider must be able to successfully validate each user
# trying to log in to Spacelift.

# Sometimes you have folks (short-term consultants, most likely) who are
# not members of your organization but need access to your Spacelift account -
# either as regular members or perhaps even as admins. Here's an example of a policy that allows
# a bunch of allow-listed folks to get regular access and one to get admin privileges:

package spacelift

admins  := { "alice@example.com" }
login   := input.session.login

admin { admins[login] }
allow { endswith(input.session.login, "@example.com") }
deny  { not admins[login]; not allow }

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample { true }
