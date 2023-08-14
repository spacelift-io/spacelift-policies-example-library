package spacelift

# This policy is a notification policy, it will send a notification when the conditions are met
# More details at: https://docs.spacelift.io/concepts/policy/notification-policy
# Here is an example for sending a custom message where a run which tries to attach 
# a policy requires confirmation:

slack[{
  "channel_id": "C0000000000",
  "message": sprintf("http://example.app.spacelift.io/stack/%s/run/%s is trying to attach a policy!", [stack.id, run.id]),
}] {
  stack := input.run_updated.stack
  run := input.run_updated.run
  run.type == "TRACKED"
  run.state == "UNCONFIRMED"
  change := run.changes[_]
  change.phase == "plan"
  change.entity.type == "spacelift_policy_attachment"
}