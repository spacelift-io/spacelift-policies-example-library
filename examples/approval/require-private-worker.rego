package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy approves any runs where the stack uses a private worker, and rejects any runs
# where the stack uses a public worker. The policy needs to define an "approve" rule as well
# as a "reject" rule to avoid the policy evaluation going into an "UNDECIDED" state for runs on private workers.

# This policy can be combined with automatic policy attachment (https://docs.spacelift.io/concepts/policy#automatically)
# to automatically enforce it across stacks.

# Approve any runs on private workers
approve if {
	not input.stack.worker_pool.public
}

# Reject any runs on public workers
reject if {
	input.stack.worker_pool.public
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
