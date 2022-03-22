package spacelift

# This example trigger policy will cause every stack that declares dependency on
# the current one to get triggered the current one is successfully updated.
#
# You can read more about trigger policies here:
#
# https://docs.spacelift.io/concepts/policy/trigger-policy

trigger[stack.id] {
  stack := input.stacks[_]
  input.run.state == "FINISHED"
  stack.labels[_] == concat("", ["depends-on:", input.stack.id])
}

# Learn more about sampling policy evaluations here:
#
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample { true }
