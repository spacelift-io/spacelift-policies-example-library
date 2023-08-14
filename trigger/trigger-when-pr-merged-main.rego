package spacelift

# This example trigger policy will cause every stack that declares dependency on
# the current one to get triggered when the current one is successfully updated.
#
# You can read more about trigger policies here:
# https://docs.spacelift.io/concepts/policy/trigger-policy

trigger["STACKB"] { finished }

finished {

# The run state is "FINISHED", meaning stack is in a "FINISHED" state
  input.run.state == "FINISHED"

# The run type is "TRACKED", meaning the run is a tracked type.
  input.run.type == "TRACKED"

# The run branch is "main", meaning the operation was performed on the main branch.
  input.run.branch == "main"
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs-inputs
sample {true}