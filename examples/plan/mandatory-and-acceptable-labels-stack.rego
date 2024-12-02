package spacelift

import future.keywords.contains
import future.keywords.if
import future.keywords.in

# METADATA
# description: Making sure mandatory labels are present and only allowing certain labels
# entrypoint: true
mandatory_labels := {
	"mandatory1",
	"mandatory2",
}

acceptable_labels := {
	"acceptable1",
	"acceptable2",
}

# Deny if mandatory labels are not present
deny contains msg if {
	not all_mandatory_labels_present(input.spacelift.stack.labels)
	msg := sprintf("Stack '%s' does not have all mandatory labels", [input.spacelift.stack.id])
}

# Deny if unacceptable labels are present
deny contains msg if {
	has_unacceptable_labels(input.spacelift.stack.labels)
	msg := sprintf("Stack '%s' has unacceptable labels", [input.spacelift.stack.id])
}

# Helper function to check if all mandatory labels are present
all_mandatory_labels_present(labels) if {
	all_labels := {label | some label in labels}
	mandatory := {label | some label in mandatory_labels}
	mandatory_subset_of_all := mandatory - all_labels
	count(mandatory_subset_of_all) == 0
}

# Helper function to check if there are any unacceptable labels
has_unacceptable_labels(labels) if {
	all_labels := {label | some label in labels}
	allowed_labels := mandatory_labels | acceptable_labels
	unallowed := all_labels - allowed_labels
	count(unallowed) > 0
}
