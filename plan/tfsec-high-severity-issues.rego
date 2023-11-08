package spacelift

# This policy checks how many high severity issues has tfsec found

warn[sprintf(message, [p])] {
	message := "You have a couple of high serverity issues: %d"
	results := input.third_party_metadata.custom.tfsec.results
	p := count({result | result := results[_]; result.severity == "HIGH"})
	p < 5
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true

# Learn more about how to integrate custom inputs here:
# https://spacelift.io/blog/integrating-security-tools-with-spacelift
