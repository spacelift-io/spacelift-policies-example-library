package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy will give you a warning if your failed checks are less than 10, but will not fail your run.

warn contains sprintf(message, [p]) if {
	message := "You have a couple of failed checks: %d"
	results := input.third_party_metadata.custom.checkov.results.failed_checks
	p := count(results)
	p < 10
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true

# Learn more about how to integrate custom inputs here:
# https://spacelift.io/blog/integrating-security-tools-with-spacelift
