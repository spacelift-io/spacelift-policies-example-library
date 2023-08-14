package spacelift

# This policy is a notification policy, it will send a notification when the conditions are met
# More details at: https://docs.spacelift.io/concepts/policy/notification-policy
#
# Filtering and selecting webhooks can be done by using the received input data. 
# Rules can be created where only specific actions should trigger a webhook being sent. 
# For example we could define a rule which would allow a webhook to be sent about any drift detection run:

webhook[{"endpoint_id": endpoint.id}] {
  endpoint := input.webhook_endpoints[_]
  endpoint.id == "drift-hook"
  input.run_updated.run.drift_detection == true
  input.run_updated.run.type == "PROPOSED"
}