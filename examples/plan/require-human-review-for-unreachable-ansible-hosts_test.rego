package spacelift

# Test case for warning when some ansible hosts were unreachable.
test_warn_ansible_host_are_unreachable {
	warn["Some hosts were unreachable"] with input as {"ansible": {"dark": {"test": true}}}
}

#

# Test case for no warning when all ansible hosts were reachable.
test_no_warn_all_ansible_host_are_reachable {
	count(warn) == 0 with input as {"ansible": {"dark": {}}}
}
