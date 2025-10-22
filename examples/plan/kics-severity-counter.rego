package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy will give you a warning with all the info, low and medium issues number
# and deny any run that has a high severity issue.

warn contains sprintf(message, [info, low, medium]) if {
	message := "You have: %d info issues, %d low issues, %d medium issues"
	info := input.third_party_metadata.custom.kics.severity_counters.INFO
	low := input.third_party_metadata.custom.kics.severity_counters.LOW
	medium := input.third_party_metadata.custom.kics.severity_counters.MEDIUM
}

deny contains sprintf(message, [results, p]) if {
	message := "The number of violated policies %d is higher than the threshold %d"
	results := input.third_party_metadata.custom.kics.severity_counters.HIGH
	p := 0
	p < results
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true

# Learn more about how to integrate custom inputs here:
# https://spacelift.io/blog/integrating-security-tools-with-spacelift
