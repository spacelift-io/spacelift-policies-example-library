package spacelift

import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Define team roles
admins := {"team1", "team2", "team3"}

writers := {"team4", "team5", "team6"}

readers := {"team7", "team8", "team9"}

# Space access rules
# Admin access rule - highest priority
space_admin contains space.id if {
	some space in input.spaces
	some login in input.session.teams
	admins[login] # User is an admin
}

# Writer access rule - second priority
# Only consider this rule if the user is not an admin
space_write contains space.id if {
	some space in input.spaces
	some login in input.session.teams
	writers[login] # User is a writer
	not admins[login] # Ensure user is not an admin
}

# Reader access rule - third priority
# Only consider this rule if the user is neither an admin nor a writer
space_read contains space.id if {
	some space in input.spaces
	some login in input.session.teams
	readers[login] # User is a reader
	not admins[login] # Ensure user is not an admin
	not writers[login] # Ensure user is not a writer
}
