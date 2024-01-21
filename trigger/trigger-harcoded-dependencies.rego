package spacelift

import future.keywords

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
