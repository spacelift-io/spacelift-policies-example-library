package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

warn contains "Drift reconciliation requires manual approval" if {
	input.spacelift.run.drift_detection
}
