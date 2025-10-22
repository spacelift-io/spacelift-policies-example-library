package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy returns warnings for every high severity issue trivy finds

warn contains sprintf("Warning due to high severity misconfiguration: %s", [title]) if {
	misconf := input.third_party_metadata.custom.trivy.Results[_].Misconfigurations[_]
	misconf.Severity == "HIGH"
	misconf.Status == "FAIL"
	title := misconf.Title
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true

# Learn more about how to integrate custom inputs here:
# https://spacelift.io/blog/integrating-security-tools-with-spacelift
