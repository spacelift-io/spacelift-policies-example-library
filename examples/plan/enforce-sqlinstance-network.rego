package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Deny changes that expose Cloud SQL instance to 0.0.0.0/0
deny contains msg if {
	change := input.terraform.resource_changes[_]
	change.type == "google_sql_database_instance"
	valid_action(change.change.actions)
	setting := change.change.after.settings[_]
	ip_config := setting.ip_configuration[_]
	auth_network := ip_config.authorized_networks[_]
	auth_network.value == "0.0.0.0/0"

	msg := sprintf("Cloud SQL instance '%s' is exposed to 0.0.0.0/0", [change.address])
}

# Helper rule to check for valid actions
valid_action(actions) if {
	action := actions[_]
	action == "update"
}

# Helper rule to check for create action
valid_action(actions) if {
	action := actions[_]
	action == "create"
}
