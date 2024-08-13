package spacelift_test

import future.keywords.if
import future.keywords.in
import future.keywords.contains

import data.spacelift

# Test successful Slack notification for a tracked, failed run
test_slack_notification_for_tracked_failed_run if {
    result := spacelift.slack with input as {
        "account": {"name": "test-account"},
        "run_updated": {
            "stack": {"id": "test-stack", "name": "Test Stack"},
            "run": {
                "id": "test-run",
                "type": "TRACKED",
                "state": "FAILED",
                "commit": {
                    "author": "GITHUB_USERNAME_EXAMPLE1",
                    "hash": "abcdef123456",
                    "url": "https://github.com/org/repo/commit/abcdef123456"
                }
            }
        }
    }

    count(result) == 1
    slack_message := result[_]
    slack_message.channel_id == "YOUR_SLACK_CHANNEL"
    contains(slack_message.message, "⚠️Spacelift Stack Failure⚠️ - `Test Stack`")
    contains(slack_message.message, "Hey <@SLACK_ID_EXAMPLE1>")
    contains(slack_message.message, "https://test-account.app.spacelift.io/stack/test-stack/run/test-run")
}

# Test no Slack notification for a non-tracked run
test_no_slack_notification_for_non_tracked_run if {
    result := spacelift.slack with input as {
        "run_updated": {
            "run": {
                "type": "PROPOSED",
                "state": "FAILED"
            }
        }
    }

    count(result) == 0
}

# Test no Slack notification for a successful FINISHED run
test_no_slack_notification_for_successful_run if {
    result := spacelift.slack with input as {
        "run_updated": {
            "run": {
                "type": "TRACKED",
                "state": "FINISHED"
            }
        }
    }

    count(result) == 0
}

# Test Slack notification with unknown GitHub user which should route to @here
test_slack_notification_with_unknown_github_user if {
    result := spacelift.slack with input as {
        "account": {"name": "test-account"},
        "run_updated": {
            "stack": {"id": "test-stack", "name": "Test Stack"},
            "run": {
                "id": "test-run",
                "type": "TRACKED",
                "state": "FAILED",
                "commit": {
                    "author": "unknown-user",
                    "hash": "abcdef123456",
                    "url": "https://github.com/org/repo/commit/abcdef123456"
                }
            }
        }
    }

    count(result) == 1
    slack_message := result[_]
    contains(slack_message.message, "Hey <@here>")
}

# Test PR comment for a tracked, failed run
test_pr_comment_for_tracked_failed_run if {
    result := spacelift.pull_request with input as {
        "account": {"name": "test-account"},
        "run_updated": {
            "stack": {"id": "test-stack", "name": "Test Stack"},
            "run": {
                "id": "test-run",
                "type": "TRACKED",
                "state": "FAILED",
                "commit": {
                    "author": "GITHUB_USERNAME_EXAMPLE1",
                    "hash": "abcdef123456",
                    "url": "https://github.com/org/repo/commit/abcdef123456"
                }
            }
        }
    }

    count(result) == 1
    pr_comment := result[_]
    pr_comment.commit == "abcdef123456"
    contains(pr_comment.body, "## ⚠️Spacelift Stack Failure⚠️")
    contains(pr_comment.body, "@GITHUB_USERNAME_EXAMPLE1")
    contains(pr_comment.body, "⛔️ `test-stack`")
    contains(pr_comment.body, "https://test-account.app.spacelift.io/stack/test-stack/run/test-run")
    pr_comment.deduplication_key == "test-stack"
}

# Test no PR comment for a non-tracked run
test_no_pr_comment_for_non_tracked_run if {
    result := spacelift.pull_request with input as {
        "run_updated": {
            "run": {
                "type": "PROPOSED",
                "state": "FAILED"
            }
        }
    }

    count(result) == 0
}

# Test no PR comment for a successful run
test_no_pr_comment_for_successful_run if {
    result := spacelift.pull_request with input as {
        "run_updated": {
            "run": {
                "type": "TRACKED",
                "state": "FINISHED"
            }
        }
    }

    count(result) == 0
}
