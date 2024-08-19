# Notify author of PR/commit which potentially introduced failure of a Spacelift Stack

package spacelift

import future.keywords.contains
import future.keywords.if

run_url := sprintf(
	"https://%s.app.spacelift.io/stack/%s/run/%s",
	[input.account.name, input.run_updated.stack.id, input.run_updated.run.id],
)

# Mapping of GitHub usernames to Slack user IDs since display names can't be tagged
# https://api.slack.com/reference/surfaces/formatting#mentioning-users
github_to_slack := {
	"GITHUB_USERNAME_EXAMPLE1": "SLACK_ID_EXAMPLE1",
	"GITHUB_USERNAME_EXAMPLE2": "SLACK_ID_EXAMPLE2",
}

github_author := input.run_updated.run.commit.author

# Function to get Slack ID corresponding to GH username from the map if exists, else, mention @here for Slack notification
slack_user_id(github_username) := slack_id if {
	slack_id := github_to_slack[github_username]
} else := "here"

# Ensure this is a tracked run and it failed
tracked_failed if {
	input.run_updated.run.type == "TRACKED"
	input.run_updated.run.state == "FAILED"
}

# Notify via Slack of the failure, mentioning author of the tracked commit that Spacelift ran on
# Hyperlinks defined as <http://www.example.com|This message *is* a link> - https://api.slack.com/reference/surfaces/formatting#linking-urls
slack contains {
	"channel_id": "YOUR_SLACK_CHANNEL",
	"message": sprintf(
		concat("", [
			"⚠️Spacelift Stack Failure⚠️ - `%s`\n",
			"Hey <@%s>, your commit/PR introduced changes that potentially caused the failure of the `%s` stack.\n",
			"Check out the <%s|run details here.>\n",
			"Tracked Commit: <%s|%s>",
		]),
		[
			input.run_updated.stack.name,
			slack_user_id,
			input.run_updated.stack.name,
			run_url,
			input.run_updated.run.commit.url,
			input.run_updated.run.commit.hash,
		],
	),
} if {
	tracked_failed
	slack_user_id := slack_user_id(github_author)
}

# Write a comment on the PR that introduced the change where this stack failed
# Use `deduplication_key` to update existing comment related to stack in place, so multiple failures of the same stack won't comment again
pull_request contains {
	"commit": input.run_updated.run.commit.hash,
	"body": sprintf(
		concat("", [
			"## ⚠️Spacelift Stack Failure⚠️\n",
			"@%s - This pull request was deployed and the following Spacelift stack failed:\n",
			"* ⛔️ `%s` - [view the run here](%s) ⛔️",
		]),
		[
			github_author,
			input.run_updated.stack.id,
			run_url,
		],
	),
	"deduplication_key": deduplication_key,
} if {
	tracked_failed
	deduplication_key := input.run_updated.stack.id
}

sample := true
