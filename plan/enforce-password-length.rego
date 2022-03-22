package spacelift

# This example plan policy prevents you from creating weak passwords, and warns 
# you when passwords are meh.
#
# You can read more about plan policies here:
#
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy

deny[sprintf("We require that passwords have at least 16 characters (%s)", [resource.address])] {
    resource := new_password[_]
    resource.change.after.length < 16
}

warn[sprintf("We advise that passwords have at least 20 characters (%s)", [resource.address])] {
    resource := new_password[_]
    resource.change.after.length < 20
}

new_password[resource] {
    resource := created_resources[_]
    resource.type == "random_password"
}

# Learn more about sampling policy evaluations here:
#
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample { true }
