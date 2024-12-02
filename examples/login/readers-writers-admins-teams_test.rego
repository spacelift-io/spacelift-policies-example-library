package spacelift_test

# Import the spacelift package to access its rules.
import data.spacelift
import future.keywords.contains
import future.keywords.if
import future.keywords.in

test_allow_writers if {
	spacelift.space_write with input as {"session": {"teams": ["team4"]}}
}

test_allow_admins if {
	spacelift.space_admin with input as {"session": {"teams": ["team1"]}}
}

test_allow_readers if {
	spacelift.space_read with input as {"session": {"teams": ["team7"]}}
}

# Test space access for admins
test_space_admin_access if {
	spacelift.space_admin with input as {"session": {"teams": ["team4"]}, "spaces": [{"id": "space1"}]}
}

# Test space access for writers
test_space_write_access if {
	spacelift.space_write with input as {"session": {"teams": ["team1"]}, "spaces": [{"id": "space1"}]}
}

# Test space access for readers
test_space_read_access if {
	spacelift.space_read with input as {"session": {"teams": ["team7"]}, "spaces": [{"id": "space1"}]}
}
