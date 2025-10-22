package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Administrative stacks are powerful - getting write access to one is almost
# as good as being an admin - you can define and attach contexts and policies.
# So let's deny write access to them entirely. This works since access policies
# are not evaluated for admin users.

deny_write if {
	input.stack.administrative
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
