package spacelift_test

import rego.v1

import data.spacelift

# Test tracking when PR is correctly labeled "deploy"
test_track_with_deploy_label if {
	test_input := {"pull_request": {"labels": ["deploy"]}}
	spacelift.track with input as test_input
}

# Test not tracking when PR does not have "deploy" label
test_not_track_without_deploy_label if {
	test_input := {"pull_request": {"labels": ["not-deploy"]}}
	not spacelift.track with input as test_input
}
