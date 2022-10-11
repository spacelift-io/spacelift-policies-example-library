package spacelift

# This policy triggers a predefined list of Stacks when a Run finishes successfully
# to create a complex workflow that spans multiple Stacks.

trigger["stack-one"] {
	finished
}

trigger["stack-two"] {
	finished
}

trigger["stack-three"] {
	finished
}

finished {
	input.run.state == "FINISHED"
	input.run.type == "TRACKED"
}
