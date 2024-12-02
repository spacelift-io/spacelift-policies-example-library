# Spacelift Policies Example Library

This repository contains a collection of Spacelift Policy examples that can be re-purposed (if needed), and used with [Spacelift](https://spacelift.io/). Spacelift Policies use the Open Policy Agent, which are written in the rego language. As you'll find in this repository, there are various types of Spacelift Policies - which allow for a lot of flexibility and customization. For more information on Spacelift Policies please refer to the [documentation](https://docs.spacelift.io/concepts/policy).

## Useful resources

- [Spacelift Policies](https://docs.spacelift.io/concepts/policy): You can find information about all available Spacelift Policy types here.
- [Open Policy Agent](https://www.openpolicyagent.org/docs/latest/policy-language/): Spacelift Policies utilize the Open Policy Agent, which uses the Rego language.
- [Spacelift Policy Workbench](https://docs.spacelift.io/concepts/policy#policy-workbench): Use the Spacelift Policy Workbench to debug your policies using sample policy inputs.
- [Testing Policies](https://docs.spacelift.io/concepts/policy#testing-policies): Learn about creating test cases for your Spacelift Policies.

## Policy Examples by Type

Policy Types Currently In This Library are below. Feel free to click on a given policy type to be taken to examples for that policy type.

| Policy Type                      | Description                                                                       |
| -------------------------------- | --------------------------------------------------------------------------------- |
| [ACCESS](examples/access/) (Deprecated) | Define who gets to access individual Stacks and with what level of access.        |
| [APPROVAL](examples/approval)           | Define who can approve or reject a run/task and how a run/task can be approved.   |
| [LOGIN](examples/login)                 | Define who gets to login to your Spacelift account and with what level of access. |
| [PLAN](examples/plan)                   | Define which changes can be applied.                                              |
| [PUSH](examples/push/)                  | Define how git push events are interpreted.                                       |
| [TRIGGER](examples/trigger)             | Define what happens when blocking runs terminate.                                 |

## All Policy Examples

### Access Policy

_Access policies have been deprecated. Please [read this](examples/access/README.md) for details._

- [Engineering Team Access](examples/access/engineering-team-access.rego)
- [Downgrade access after hours](examples/access/downgrade-access-after-hours.rego)
- [Label Based Team Access](examples/access/label-based-team-access.rego)
- [Protect Administrative Stacks](examples/access/protect-administrative-stacks.rego)
- [Slack Channel Access](examples/access/slack-channel-access.rego)
- [Who When Where Access Restrictions](examples/access/who-when-where-access-restrictions.rego)

### Approval Policy

- [Allowlist Task Commands](examples/approval/allowlist-task-commands.rego)
- [Approval needed outside working hours](examples/approval/approval-outside-working-hours.rego)
- [Require private worker](examples/approval/require-private-worker.rego)
- [Role-based Approval](examples/approval/role-based-approval.rego)
- [Require Approval from Security Team for certain resources](examples/approval/require-approval-from-security-team.rego)
- [Task and Run Approvals](examples/approval/task-and-run-approvals.rego)
- [Two Approvals Two Rejections](examples/approval/two-approvals-two-rejections.rego)
- [Two Approvals Two Rejections](examples/approval/two-approvals-two-rejections.rego)

### Login Policy

- External Contributor Access:
  - [GitHub](examples/login/external-contributor-access-github.rego)
  - [Google](examples/login/external-contributor-access-google.rego)
- [Managing access levels within an organization](examples/login/access-levels-within-an-organization.rego)
- [Readers Writers Admins Teams](examples/login/readers-writers-admins-teams.rego)
- [Rewriting User Teams](examples/login/rewriting-user-teams.rego)
- [Who When Where Login Restrictions](examples/login/who-when-where-login-restrictions.rego)

### Notification Policy

- [Drift Detection with changes](examples/notification/drift-detection-with-changes.rego)
- [Slack Channels set with labels](examples/notification/slack-channels-with-labels.rego)
- [Notification for link to failure logs](examples/notification/notification-failure.rego)
- [Notification for Origins of Failed Stacks](examples/notification/notification-stack-failure-origins.rego)

### Plan Policy

- [Check blast radius](examples/plan/check-blast-radius.rego)
- [Check sanitized value](examples/plan/check-sanitized-value.rego)
- [Checkov failed checks](examples/plan/checkov-failed-checks.rego)
- [Deny on proposed runs but warn on tracked runs](examples/plan/deny-proposed-runs-warn-track-runs.rego)
- [Do not delete stateful resources](examples/plan/do-not-delete-stateful-resources.rego)
- [Don't Allow Resource Type](examples/plan/dont-allow-resource-type.rego)
- [Enforce cloud provider](examples/plan/enforce-cloud-provider.rego)
- [Enforce Instance Type List](examples/plan/enforce-instance-type-list.rego)
- [Enforce module use policy](examples/plan/enforce-module-use-policy.rego)
- [Enforce Password Length](examples/plan/enforce-password-length.rego)
- [Enforce Google Cloud SQL Instance Networks](examples/plan/enforce-sqlinstance-network.rego)
- [Enforce Tags on Resources](examples/plan/enforce-tags-on-resources.rego)
- [Enforce Terraform version list](examples/plan/enforce-terraform-version-list.rego)
- [Ensure resource creation before deletion](examples/plan/ensure-resource-creation-before-deletion.rego)
- [Infracost Monthly Cost Restriction](examples/plan/infracost-monthly-cost-restriction.rego)
- [Kics severity counter](examples/plan/kics-severity-counter.rego)
- [Mandatory and Acceptable Labels for GCP resources](examples/plan/mandatory-and-acceptable-labels-gcp.rego)
- [Mandatory and required labels for stacks](examples/plan/mandatory-and-acceptable-labels-stack.rego)
- [Require human review for drift detection reconciliation](examples/plan/require-human-review-for-drift-detection-reconciliation.rego)
- [Require human review for unreachable Ansible hosts](examples/plan/require-human-review-for-unreachable-ansible-hosts.rego)
- [Require human review for resource update and deletion](examples/plan/require-human-review-for-update-deletion.rego)
- [Require reasonable commit size](examples/plan/require-reasonable-commit-size.rego)
- [Trusted engineers bypass review](examples/plan/trusted-engineers-bypass-review.rego)
- [Terrascan violated policies](examples/plan/terrascan-violated-policies.rego)
- [Tfsec high severity issues](examples/plan/tfsec-high-severity-issues.rego)
- [Warn On Change To Sensitive Resources](examples/plan/warn-on-change-senstitive-resources.rego)

### Push Policy

- [Allow forks](examples/push/allow-forks.rego)
- [Cancel In Progress Runs](examples/push/cancel-in-progress-runs.rego)
- [Create Proposed Run From PR Label](examples/push/create-proposed-run-from-env-pr-labels.rego)
- [Deploy with Git tag](examples/push/deploy-with-git-tag.rego)
- [Deploy with PR label](examples/push/deploy-with-pr-label.rego)
- [Ignore Changes Outside Root](examples/push/ignore-changes-outside-root.rego)
- [Terragrunt Monorepo Ignore Changes Outside Root](examples/push/terragrunt-monorepo-ignore-changes-outside-root.rego)
- [Lock button pauses runs by push events](/examples/push/lock-button-pauses-runs-by-pushes.rego)
- [PR comment-driven actions](examples/push/pr-comment-driven-actions.rego)
- [PR comment-driven user specific actions](examples/push/pr-comment-driven-user.rego)
- [PRs Only](examples/push/prs-only.rego)
- [Set head commit but don't trigger run](examples/push/set-head-commit-no-trigger.rego)
- [Tag-driven Terraform module release flow](examples/push/tag-driven-tf-module-release-flow.rego)
- [Track using labels](examples/push/track-using-labels.rego)

### Trigger Policy

- [Automated Retries](examples/trigger/automated-retries.rego)
- [Trigger Dependencies via Labels](examples/trigger/trigger-dependencies-via-labels.rego)
- [Trigger Dependencies via Labels, with state](examples/trigger/trigger-dependencies-via-labels-with-state.rego)
- [Trigger hardcoded dependencies](examples/trigger/trigger-harcoded-dependencies.rego)

## Policy Tests

Tests can be added for policies using the convention `<policy_filename>_test.rego`. For example
if you have a policy called `plan.rego`, you can create a test file called `plan_test.rego`.

You can use the following command to run all policy tests:

```shell
./run_policy_tests.sh
```
