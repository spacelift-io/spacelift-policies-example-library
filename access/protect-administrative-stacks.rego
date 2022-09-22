package spacelift

# Administrative stacks are powerful - getting write access to one is almost 
# as good as being an admin - you can define and attach contexts and policies. 
# So let's deny write access to them entirely. This works since access policies 
# are not evaluated for admin users.

deny_write {
	input.stack.administrative
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
