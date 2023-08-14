package spacelift

# This policy is a notification policy, it will send a notification when the conditions are met
# More details at: https://docs.spacelift.io/concepts/policy/notification-policy
# This policy will allow a notification to be sent about a drift detection run when there are changes:

slack[{"channel_id": "C0000000000"}] {

  # Checking if drift detection is present in the run update
  run := input.run_updated.run
  run.drift_detection == true

  # Condition to verify that there is at least one change
  count(input.run_updated.run.changes) > 0
}