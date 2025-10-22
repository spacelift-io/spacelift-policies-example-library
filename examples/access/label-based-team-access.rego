package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# This policy allow you to tag a repo with a "access:<level>:<team>" label to
#  grant access to Stacks via labels.

# In lieu of rego not yet having a regex.replace this does the friendly name to
#   GitHub ID sanitization
# "My_Team is - awesome" -> "my_team-is-awesome"`
trim_whitespace(s) := concat("-", parts) if {
	parts := [lower(part) |
		some part in split(s, " ")
		not part in {"-"}
	]
}

# Convert all Teams to the ID format
teams contains trim_whitespace(input.session.teams[_])

# Find access pattern matching labels and return just "access:team" for each
labels contains trim_prefix(label, "access:") if {
	some label in input.stack.labels
	not label == ""
	regex.match(`^access:(read|write|deny):[^:]+$`, label)
}

# check if any team would allow request "access" level
test(access) if {
	some team in teams
	labels[concat(":", [access, team])]
}

deny := test("deny")

write := test("write")

read := test("read")

# Never allow write access to administrative stacks
deny_write if input.stack.administrative

# Turn on input sampling for all attempts
sample := true
