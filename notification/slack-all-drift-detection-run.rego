package spacelift

# This policy is a notification policy, it will send a notification when the conditions are met
# More details at: https://docs.spacelift.io/concepts/policy/notification-policy
# This policy will allow a notification to be sent about any drift detection run:

slack[{"channel_id": "C0000000000"}] {

  run := input.run_updated.run
  run.drift_detection == true
  run.type == "PROPOSED"
}

