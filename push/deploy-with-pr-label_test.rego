package spacelift_test

import data.spacelift
import future.keywords.if

# Test tracking when PR is correctly labeled "deploy"
test_track_with_deploy_label if {
	input := {"pull_request": {"labels": ["deploy"]}}
	spacelift.track with input as input
}

# Test not tracking when PR does not have "deploy" label
test_not_track_without_deploy_label if {
	input := {"pull_request": {"labels": ["not-deploy"]}}
	not spacelift.track with input as input
}
