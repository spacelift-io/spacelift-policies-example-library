package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy emits warning when some of the Ansbile hosts were unreachable
# so that a human review is required.

warn contains "Some hosts were unreachable" if {
	input.ansible.dark != {}
}

sample := true
