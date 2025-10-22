package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

slack contains {"channel_id": "C000000"} if {
	# Checking if drift detection is present in the run update
	input.run_updated.run.drift_detection

	# Condition to verify that there is at least one change
	count(input.run_updated.run.changes) > 0
}

sample := true
