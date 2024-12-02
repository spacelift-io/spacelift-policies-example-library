package spacelift

import future.keywords.contains
import future.keywords.if
import future.keywords.in

mandatory_labels := {"mandatory1", "mandatory2"}

acceptable_labels := {"acceptable1", "acceptable2"}

mandatory_resources := {
	"google_redis_instance",
	"google_spanner_instance",
	"google_storage_bucket",
}

deny contains msg if {
	some change in input.spacelift.run.changes
	is_mandatory_resource(change.entity.type, mandatory_resources)
	labels := change.entity.data.values.labels
	missing_any_mandatory_label(labels, mandatory_labels)
	msg := sprintf(
		"Resource '%s' is missing mandatory labels: %v",
		[change.entity.address, which_labels_missing(labels, mandatory_labels)],
	)
}

deny contains msg if {
	some change in input.spacelift.run.changes
	is_mandatory_resource(change.entity.type, mandatory_resources)
	labels := change.entity.data.values.labels
	has_non_acceptable_labels(labels, mandatory_labels, acceptable_labels)
	msg := sprintf("Resource '%s' has invalid labels.", [change.entity.address])
}

is_mandatory_resource(entity_type, resources) if {
	entity_type in resources
}

missing_any_mandatory_label(labels, mandatory) if {
	some label in mandatory
	not labels[label]
}

has_non_acceptable_labels(labels, mandatory, acceptable) if {
	some label in labels
	not mandatory[label]
	not acceptable[label]
}

which_labels_missing(labels, mandatory) := {label |
	some label in mandatory
	not labels[label]
}
