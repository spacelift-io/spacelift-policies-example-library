package spacelift

# This policy attempts to create a metric called a "blast radius" - that is how much the change will affect the whole stack.
# It assigns special multipliers to some types of resources changed and treats different types of changes differently:
# deletes and updates are more "expensive" because they affect live resources, while new resources are generally safer
# and thus "cheaper". We will fail Pull Requests with changes violating this policy, but require human action
# through **warnings** when these changes hit the tracked branch.

proposed := input.spacelift.run.type == "PROPOSED"

deny[msg] {
	proposed
	msg := blast_radius_too_high[_]
}

warn[msg] {
	not proposed
	msg := blast_radius_too_high[_]
}

blast_radius_too_high[sprintf("change blast radius too high (%d/100)", [blast_radius])] {
	blast_radius := sum([blast |
		resource := input.terraform.resource_changes[_]
		blast := blast_radius_for_resource(resource)
	])

	blast_radius > 100
}

blast_radius_for_resource(resource) = ret {
	blasts_radii_by_action := {"delete": 10, "update": 5, "create": 1, "no-op": 0}

	ret := sum([value |
		action := resource.change.actions[_]
		action_impact := blasts_radii_by_action[action]
		type_impact := blast_radius_for_type(resource.type)
		value := action_impact * type_impact
	])
}

# Let's give some types of resources special blast multipliers.
blasts_radii_by_type := {"aws_ecs_cluster": 20, "aws_ecs_user": 10, "aws_ecs_role": 5}

# By default, blast radius has a value of 1.
blast_radius_for_type(type) = 1 {
	not blasts_radii_by_type[type]
}

blast_radius_for_type(type) = ret {
	blasts_radii_by_type[type] = ret
}
