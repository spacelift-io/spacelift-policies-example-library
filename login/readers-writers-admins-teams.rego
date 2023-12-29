package spacelift

# Define team roles
writers := {"team1", "team2", "team3"}

admins := {"team4", "team5", "team6"}

readers := {"team7", "team8", "team9"}

# Extract login from session
login := input.session.teams

# Allow based on team role
allow { # Allow writers
	writers[login]
}

allow { # Allow admins
	admins[login]
}

allow { # Allow readers
	readers[login]
}

# Space access rules
# Check if user is an admin and assign admin access to the space
space_admin[space.id] {
	space := input.spaces[_]
	admins[login]
}

# Check if user is a writer and assign write access to the space
space_write[space.id] {
	space := input.spaces[_]
	writers[login]
}

# Check if user is a reader and assign read access to the space
space_read[space.id] {
	space := input.spaces[_]
	readers[login]
}
