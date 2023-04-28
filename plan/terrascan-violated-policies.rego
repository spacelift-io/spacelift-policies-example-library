package spacelift

# This policy checks the number of violated terrascan policies 
# and shows a warning with the number of them, also, if the number of violated policies is greater than 2, it will deny the run.

warn[sprintf(message, [results])] {
	message := "You have a couple of violated policies: %d"
	results := input.third_party_metadata.custom.terrascan.results.scan_summary.violated_policies
}

deny[sprintf(message, [results, p])] {
	message := "The number of violated policies %d is higher than the threshold %d"
	results := input.third_party_metadata.custom.terrascan.results.scan_summary.violated_policies
	p := 2
	p < results
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true

# Learn more about how to integrate custom inputs here: 
# https://spacelift.io/blog/integrating-security-tools-with-spacelift
