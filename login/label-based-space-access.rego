package play

# Find access-pattern-matching labels and return "<SPACE ID>:<ACCESS LEVEL>:<TEAM>" for each
labels := {sprintf("%s:%s", [space.id, trim_prefix(label, "access:")]) |
	space := input.spaces[_]
	label := space.labels[_]
	regex.match("^access:(read|write|admin):[^:]+$", label)
}

space_read[space.id] {
	space := input.spaces[_]
	team := input.session.teams[_]
	labels[concat(":", [space.id, "read", team])]
}

space_write[space.id] {
	space := input.spaces[_]
	team := input.session.teams[_]
	labels[concat(":", [space.id, "write", team])]
}

space_admin[space.id] {
	space := input.spaces[_]
	team := input.session.teams[_]
	labels[concat(":", [space.id, "admin", team])]
}

# Enable sampling
sample := true
