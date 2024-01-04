package spacelift

# Test for writers
test_allow_writers {
	allow with input as {"session": {"teams": "team1"}} with input.spaces as [{"id": "space1"}, {"id": "space2"}]
}

test_deny_non_writers {
	not allow with input as {"session": {"teams": "non_writer_team"}} with input.spaces as [{"id": "space1"}, {"id": "space2"}]
}

# Test for admins
test_allow_admins {
	allow with input as {"session": {"teams": "team4"}} with input.spaces as [{"id": "space1"}, {"id": "space2"}]
}

test_deny_non_admins {
	not allow with input as {"session": {"teams": "non_admin_team"}} with input.spaces as [{"id": "space1"}, {"id": "space2"}]
}

# Test for readers
test_allow_readers {
	allow with input as {"session": {"teams": "team7"}} with input.spaces as [{"id": "space1"}, {"id": "space2"}]
}

test_deny_non_readers {
	not allow with input as {"session": {"teams": "non_reader_team"}} with input.spaces as [{"id": "space1"}, {"id": "space2"}]
}

# Test space access for admins
test_space_admin_access {
	space_admin.space1 with input as {"session": {"teams": "team4"}, "spaces": [{"id": "space1"}, {"id": "space2"}]}
}

test_space_admin_no_access {
	not space_admin.space1 with input as {"session": {"teams": "team1"}, "spaces": [{"id": "space1"}, {"id": "space2"}]}
}

# Test space access for writers
test_space_write_access {
	space_write.space1 with input as {"session": {"teams": "team1"}, "spaces": [{"id": "space1"}, {"id": "space2"}]}
}

test_space_write_no_access {
	not space_write.space1 with input as {"session": {"teams": "team7"}, "spaces": [{"id": "space1"}, {"id": "space2"}]}
}

# Test space access for readers
test_space_read_access {
	space_read.space1 with input as {"session": {"teams": "team7"}, "spaces": [{"id": "space1"}, {"id": "space2"}]}
}

test_space_read_no_access {
	not space_read.space1 with input as {"session": {"teams": "team1"}, "spaces": [{"id": "space1"}, {"id": "space2"}]}
}
