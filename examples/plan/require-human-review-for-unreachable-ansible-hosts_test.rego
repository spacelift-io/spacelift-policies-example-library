package spacelift_test

import data.spacelift
import rego.v1

# Test case for warning when some ansible hosts were unreachable.
test_warn_ansible_host_are_unreachable if {
	spacelift.warn["Some hosts were unreachable"] with input as {"ansible": {"dark": {"test": true}}}
}

#

# Test case for no warning when all ansible hosts were reachable.
test_no_warn_all_ansible_host_are_reachable if {
	count(spacelift.warn) == 0 with input as {"ansible": {"dark": {}}}
}
