package spacelift

import future.keywords

# Sometimes Terraform or Pulumi deployments fail for a reason that has nothing to do
# with the code - think eventual consistency between various cloud subsystems, transient
# API errors etc. It would be great if you could restart the failed run. Oh, and let's
# make sure new runs are not created in a crazy loop - since policy-triggered runs
# trigger another policy evaluation:

trigger contains stack.id if {
	stack := input.stack
	input.run.state == "FAILED"
	input.run.type == "TRACKED"
	is_null(input.run.triggered_by)
}

# Note: This will also prevent user-triggered runs from being retried.

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
