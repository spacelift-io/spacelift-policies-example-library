package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy triggers a predefined list of Stacks when a Run finishes successfully
# to create a complex workflow that spans multiple Stacks.

trigger contains "stack-one" if {
	finished
}

trigger contains "stack-two" if {
	finished
}

trigger contains "stack-three" if {
	finished
}

finished if {
	input.run.state == "FINISHED"
	input.run.type == "TRACKED"
}
