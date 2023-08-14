package spacelift

# This policy is a notification policy, it will send a notification when the conditions are met
# More details at: https://docs.spacelift.io/concepts/policy/notification-policy
#
# This policy is a inbox rule which will send INFO level notification messages to your inbox when a tracked run has finished

 inbox[{
  "title": "Tracked run finished!",
  "body": sprintf("http://example.app.spacelift.io/stack/%s/run/%s has finished", [stack.id, run.id]),
  "severity": "INFO",
 }] {
   stack := input.run_updated.stack
   run := input.run_updated.run
   run.type == "TRACKED"
   run.state == "FINISHED"
 }