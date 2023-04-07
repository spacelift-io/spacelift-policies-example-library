package spacelift

test_read {
	space_read["space-a"] with input as {
		"session": {"teams": ["team-1"]},
		"spaces": [
			{
				"id": "space-a",
				"labels": ["access:read:team-1"]
			},
		]
	}
}
