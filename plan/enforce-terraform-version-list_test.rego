package spacelift

# Test for denied versions
test_deny_1_4_1 {
	input := {"terraform": {"terraform_version": "1.4.1"}}
	count(deny) == 1 with input as input
	count(warn) == 0 with input as input
}

test_deny_1_4_2 {
	input := {"terraform": {"terraform_version": "1.4.2"}}
	count(deny) == 1 with input as input
	count(warn) == 0 with input as input
}

test_deny_1_4_3 {
	input := {"terraform": {"terraform_version": "1.4.3"}}
	count(deny) == 1 with input as input
	count(warn) == 0 with input as input
}

# Test for allowed versions (should not warn or deny)
test_allow_1_4_4 {
	input := {"terraform": {"terraform_version": "1.4.4"}}
	count(deny) == 0 with input as input
	count(warn) == 0 with input as input
}

test_allow_1_4_5 {
	input := {"terraform": {"terraform_version": "1.4.5"}}
	count(deny) == 0 with input as input
	count(warn) == 0 with input as input
}

test_allow_1_5_0 {
	input := {"terraform": {"terraform_version": "1.5.0"}}
	count(deny) == 0 with input as input
	count(warn) == 0 with input as input
}

# Test for versions that should generate a warning
test_warn_1_4_0 {
	input := {"terraform": {"terraform_version": "1.4.0"}}
	count(deny) == 0 with input as input
	count(warn) == 1 with input as input
}

test_warn_1_5_1 {
	input := {"terraform": {"terraform_version": "1.5.1"}}
	count(deny) == 0 with input as input
	count(warn) == 1 with input as input
}
