package spacelift_test

import data.spacelift
import rego.v1

test_reject_public_worker if {
	spacelift.reject with input as {"stack": {"worker_pool": {"public": true}}}
}

test_reject_private_worker if {
	not spacelift.reject with input as {"stack": {"worker_pool": {"public": false}}}
}

test_approve_public_worker if {
	not spacelift.approve with input as {"stack": {"worker_pool": {"public": true}}}
}

test_approve_private_worker if {
	spacelift.approve with input as {"stack": {"worker_pool": {"public": false}}}
}
