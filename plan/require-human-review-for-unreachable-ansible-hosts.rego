package spacelift

# This policy emits warning when some of the Ansbile hosts were unreachable
# so that a human review is required.

warn["Some hosts were unreachable"] {
	input.ansible.dark != {}
}

sample = true
