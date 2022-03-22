package spacelift

# This example plan policy prevents you from creating resources of type random_id
#
# You can read more about plan policies here:
#
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy


deny[sprintf("Don't recreate random ID %s", [resource.address])] {
  some resource 
  resource = recreated_resources[_]
  
  resource.type == "random_id"
}

# Learn more about sampling policy evaluations here:
#
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs

sample { true }
