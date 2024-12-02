package spacelift

# This policy will give you a warning with all the info, low and medium issues number
# and deny any run that has a high severity issue.

warn[sprintf(message, [info, low, medium])] {
	message := "You have: %d info issues, %d low issues, %d medium issues"
	info := input.third_party_metadata.custom.kics.severity_counters.INFO
	low := input.third_party_metadata.custom.kics.severity_counters.LOW
	medium := input.third_party_metadata.custom.kics.severity_counters.MEDIUM
}

deny[sprintf(message, [results, p])] {
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
