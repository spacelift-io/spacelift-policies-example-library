package spacelift

import future.keywords.contains
import future.keywords.if
import future.keywords.in

ir := input.run_updated

run := sprintf("https://%s.app.spacelift.io/stack/%s/run/%s", [input.account.name, ir.stack.id, ir.run.id])

failed if {
	input.run_updated.run.state == "FAILED"
}

slack contains {
	"channel_id": "C05H9PV1TK9",
	"message": msg,
} if {
	failed
	any_deny_or_reject
	some pr in ir.policy_receipts
	msg := sprintf("The run failed as the %s policy had a %s outcome. Details: %s", [pr.name, pr.outcome, run])
}

slack contains {
	"channel_id": "C05H9PV1TK9",
	"message": msg,
} if {
	failed
	not any_deny_or_reject
	msg := sprintf("The run failed, you can review the logs to see why here: %s", [run])
}

any_deny_or_reject if {
	some pr in ir.policy_receipts
	pr.outcome == "deny"
}

any_deny_or_reject if {
	some pr in ir.policy_receipts
	pr.outcome == "reject"
}

sample := true
