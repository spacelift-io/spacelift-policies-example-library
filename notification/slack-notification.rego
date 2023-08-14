package spacelift

# This policy is a notification policy, it will send a notification when the conditions are met
# More details at: https://docs.spacelift.io/concepts/policy/notification-policy
# if you wanted to receive only finished runs on a specific Slack channel, you would define a rule like this.

slack[{"channel_id": "C0000000000"}] {
  input.run_updated != null

  run := input.run_updated.run
  run.state == "FINISHED"
}