package spacelift_test

import data.spacelift
import rego.v1

# Test allowing a valid Cloud SQL instance configuration
test_allow_valid_cloud_sql_instance if {
	count(spacelift.deny) == 0 with input as {"terraform": {"resource_changes": [{
		"type": "google_sql_database_instance",
		"change": {
			"actions": ["create"],
			"after": {"settings": [{"ip_configuration": [{"authorized_networks": [{"value": "192.168.1.0/24"}]}]}]},
		},
	}]}}
}

# Test denying a Cloud SQL instance open to 0.0.0.0/0
test_deny_cloud_sql_instance_open_to_world if {
	spacelift.deny with input as {"terraform": {"resource_changes": [{
		"type": "google_sql_database_instance",
		"change": {
			"actions": ["create"],
			"after": {"settings": [{"ip_configuration": [{"authorized_networks": [{"value": "0.0.0.0/0"}]}]}]},
		},
	}]}}
}

# Test non-applicability for a non-Cloud SQL resource
test_allow_non_cloud_sql_resource if {
	count(spacelift.deny) == 0 with input as {"terraform": {"resource_changes": [{
		"type": "google_compute_instance",
		"change": {
			"actions": ["create"],
			"after": {"settings": [{"ip_configuration": [{"authorized_networks": [{"value": "0.0.0.0/0"}]}]}]},
		},
	}]}}
}
