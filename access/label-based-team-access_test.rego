package spacelift

# in most cases read/write/deny act exactly the same, so tests
#   will only focus on specifics for those when it applies

test_no_denywrite_if_nothing {
	not deny_write with input as {
		"session": {"teams": []},
		"stack": {"labels": []},
	}
}

test_denywrite_if_administrative {
	deny_write with input as {
		"session": {"teams": []},
		"stack": {
			"administrative": true,
			"labels": [],
		},
	}
}

test_no_write_if_nothing {
	not write with input as {
		"session": {"teams": []},
		"stack": {"labels": []},
	}
}

test_no_write_if_label {
	not write with input as {
		"session": {"teams": []},
		"stack": {"labels": ["access:write:my-team"]},
	}
}

test_no_write_if_wrong_team {
	not write with input as {
		"session": {"teams": ["My_Team"]},
		"stack": {"labels": ["access:write:my-team"]},
	}
}

test_write_if_correct_team {
	write with input as {
		"session": {"teams": ["My Team"]},
		"stack": {"labels": ["access:write:my-team"]},
	}
}

test_write_if_correct_team2 {
	write with input as {
		"session": {"teams": ["My - Team"]},
		"stack": {"labels": ["access:write:my-team"]},
	}
}

test_no_write_if_wrong_level {
	not write with input as {
		"session": {"teams": ["My - Team"]},
		"stack": {"labels": ["access:read:my-team"]},
	}
}

test_no_write_if_wrong_wrong_label {
	not write with input as {
		"session": {"teams": ["My - Team"]},
		"stack": {"labels": ["access:write:*"]},
	}
}

test_no_write_if_wrong_wrong_label2 {
	not write with input as {
		"session": {"teams": ["My - Team"]},
		"stack": {"labels": ["write"]},
	}
}

test_no_write_if_wrong_wrong_label3 {
	not write with input as {
		"session": {"teams": ["My - Team"]},
		"stack": {"labels": ["write:my-team"]},
	}
}

test_no_write_if_wrong_wrong_label4 {
	not write with input as {
		"session": {"teams": ["My - Team"]},
		"stack": {"labels": ["access:write:my-team:haha"]},
	}
}
