package spacelift_test

import data.spacelift
import future.keywords

# Test when run is finished and dependent stack is present
test_trigger_dependency_present if {
	result := spacelift.trigger with input as {
		"run": {"state": "FINISHED"},
		"stack": {"id": "debugtest"},
		"stacks": [{
			"id": "dependentstack",
			"labels": ["depends-on:debugtest"],
		}],
	}
	result.dependentstack
}

# Test when run is finished but no dependent stack is present
test_trigger_no_dependency if {
	count(spacelift.trigger) == 0 with input as {
		"run": {"state": "FINISHED"},
		"stack": {"id": "debugtest"},
		"stacks": [{
			"id": "independentstack",
			"labels": ["no-dependency"],
		}],
	}
}

# Test when run is not finished but dependent stack is present
test_trigger_run_not_finished if {
	count(spacelift.trigger) == 0 with input as {
		"run": {"state": "UNCONFIRMED"},
		"stack": {"id": "debugtest"},
		"stacks": [{
			"id": "dependentstack",
			"labels": ["depends-on:debugtest"],
		}],
	}
}
