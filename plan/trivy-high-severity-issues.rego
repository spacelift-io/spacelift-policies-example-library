package spacelift

# This policy returns warnings for every high severity issue trivy finds

warn [sprintf("Warning due to high severity misconfiguration: %s", [Title])] {
    misconf := input.third_party_metadata.custom.trivy.Results[_].Misconfigurations[_]
    misconf.Severity == "HIGH"
    misconf.Status == "FAIL"
    Title := misconf.Title
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true

# Learn more about how to integrate custom inputs here:
# https://spacelift.io/blog/integrating-security-tools-with-spacelift
