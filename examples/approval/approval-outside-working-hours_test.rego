package spacelift_test

import data.spacelift
import rego.v1

# Mock data
mock_created_at_weekday_morning := 1692790710000000000

mock_created_at_weekday_evening := 1692823110000000000

mock_created_at_weekend := 1692477510000000000

# Test automatic approval for a weekday between 9am to 5pm
test_automatic_approve_weekday_morning if {
	spacelift.approve with input as {
		"run": {"created_at": mock_created_at_weekday_morning},
		"reviews": {"current": {"approvals": [], "rejections": []}},
	}
}

# Test required approval for a weekday after 5pm
test_required_approval_weekday_evening if {
	spacelift.approve with input as {
		"run": {"created_at": mock_created_at_weekday_evening},
		"reviews": {"current": {"approvals": ["user1"], "rejections": []}},
	}
}

# Test missing approval for a weekday after 5pm
test_missing_approval_weekday_evening if {
	not spacelift.approve with input as {
		"run": {"created_at": mock_created_at_weekday_evening},
		"reviews": {"current": {"approvals": [], "rejections": []}},
	}
}

# Test required approval during weekend
test_required_approval_weekend if {
	spacelift.approve with input as {
		"run": {"created_at": mock_created_at_weekend},
		"reviews": {"current": {"approvals": ["user1"], "rejections": []}},
	}
}

# Test missing approval during weekend
test_missing_approval_weekend if {
	not spacelift.approve with input as {
		"run": {"created_at": mock_created_at_weekend},
		"reviews": {"current": {"approvals": [], "rejections": []}},
	}
}

# Test reject due to a rejection review
test_rejection_due_to_review if {
	spacelift.reject with input as {
		"run": {"created_at": mock_created_at_weekend},
		"reviews": {"current": {"approvals": ["user1"], "rejections": ["user2"]}},
	}
}

# Test no rejection when there's no rejection review
test_no_rejection_when_no_review if {
	not spacelift.reject with input as {
		"run": {"created_at": mock_created_at_weekend},
		"reviews": {"current": {"approvals": ["user1"], "rejections": []}},
	}
}
