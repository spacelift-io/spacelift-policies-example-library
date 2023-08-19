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
| [ACCESS](./access/) (Deprecated) | Define who gets to access individual Stacks and with what level of access.        |
| [APPROVAL](./approval)           | Define who can approve or reject a run/task and how a run/task can be approved.   |
| [LOGIN](./login)                 | Define who gets to login to your Spacelift account and with what level of access. |
| [PLAN](./plan)                   | Define which changes can be applied.                                              |
| [PUSH](./push/)                  | Define how git push events are interpreted.                                       |
| [TRIGGER](./trigger)             | Define what happens when blocking runs terminate.                                 |

## All Policy Examples

### Access Policy

_Access policies have been deprecated. Please [read this](./access/README.md) for details._

- [Engineering Team Access](./access/engineering-team-access.rego)
- [Downgrade access after hours](./access/downgrade-access-after-hours.rego)
- [Label Based Team Access](./access/label-based-team-access.rego)
- [Protect Administrative Stacks](./access/protect-administrative-stacks.rego)
- [Slack Channel Access](./access/slack-channel-access.rego)
- [Who When Where Access Restrictions](./access/who-when-where-access-restrictions.rego)

### Approval Policy

- [Allowlist Task Commands](./approval/allowlist-task-commands.rego)
- [Require private worker](./approval/require-private-worker.rego)
- [Role-based Approval](./approval/role-based-approval.rego)
- [Task and Run Approvals](./approval/task-and-run-approvals.rego)
- [Two Approvals Two Rejections](./approval/two-approvals-two-rejections.rego)
- [Two Approvals Two Rejections](./approval/two-approvals-two-rejections.rego)

### Login Policy

- External Contributor Access:
  - [GitHub](./login/external-contributor-access-github.rego)
  - [Google](./login/external-contributor-access-google.rego)
- [Managing access levels within an organization](./login/access-levels-within-an-organization.rego)
- [Rewriting User Teams](./login/rewriting-user-teams.rego)
- [Who When Where Login Restrictions](./login/who-when-where-login-restrictions.rego)

### Plan Policy

- [Check blast radius](./plan/check-blast-radius.rego)
- [Check sanitized value](./plan/check-sanitized-value.rego)
- [Deny on proposed runs but warn on tracked runs](./plan/deny-proposed-runs-warn-track-runs.rego)
- [Do not delete stateful resources](./plan/do-not-delete-stateful-resources.rego)
- [Don't Allow Resource Type](./plan/dont-allow-resource-type.rego)
- [Enforce cloud provider](./plan/enforce-cloud-provider.rego)
- [Enforce Password Strength](./plan/enforce-password-length.rego)
- [Enforce Tags on Resources](./plan/enforce-tags-on-resources.rego)
- [Ensure resource creation before deletion](./plan/ensure-resource-creation-before-deletion.rego)
- [Infracost Monthly Cost Restriction](./plan/infracost-monthly-cost-restriction.rego)
- [Require human review for drift detection reconciliation](./plan/require-human-review-for-drift-detection-reconciliation.rego)
- [Require human review for unreachable Ansible hosts](./plan/require-human-review-for-unreachable-ansible-hosts.rego)
- [Require human review for resource update and deletion](./plan/require-human-review-for-update-deletion.rego)
- [Require reasonable commit size](./plan/require-reasonable-commit-size.rego)
- [Trusted engineers bypass review](./plan/trusted-engineers-bypass-review.rego)
- [Enforce module use policy](./plan/enforce-module-use-policy.rego)
- [Checkov failed checks](./plan/checkov-failed-checks.rego)
- [Kics severity counter](./plan/kics-severity-counter.rego)
- [Terrascan violated policies](./plan/terrascan-violated-policies.rego)
- [Tfsec high severity issues](./plan/tfsec-high-severity-issues.rego)
- [Warn On Change To Sensitive Resources](./plan/warn-on-change-senstitive-resources.rego)

### Push Policy

- [Allow forks](./push/allow-forks.rego)
- [Cancel In Progress Runs](./push/cancel-in-progress-runs.rego)
- [Create Proposed Run From PR Label](./push/create-proposed-run-from-env-pr-labels.rego)
- [Deploy with Git tag](./push/deploy-with-git-tag.rego)
- [Deploy with PR label](./push/deploy-with-pr-label.rego)
- [Ignore Changes Outside Root](./push/ignore-changes-outside-root.rego)
- [Terragrunt Monorepo Ignore Changes Outside Root](./push/terragrunt-monorepo-ignore-changes-outside-root.rego)
- [PR comment-driven actions](./push/pr-comment-driven-actions.rego)
- [PRs Only](./push/prs-only.rego)
- [Set head commit but don't trigger run](./push/set-head-commit-no-trigger.rego)
- [Tag-driven Terraform module release flow](./push/tag-driven-tf-module-release-flow.rego)

### Trigger Policy

- [Automated Retries](./trigger/automated-retries.rego)
- [Trigger Dependencies via Labels](./trigger/trigger-dependencies-via-labels.rego)
- [Trigger Dependencies via Labels, with state](./trigger/trigger-dependencies-via-labels-with-state.rego)
- [Trigger hardcoded dependencies](./trigger/trigger-harcoded-dependencies.rego)

## Policy Tests

Tests can be added for policies using the convention `<policy_filename>_test.rego`. For example
if you have a policy called `plan.rego`, you can create a test file called `plan_test.rego`.

You can use the following command to run all policy tests:

```shell
./run_policy_tests.sh
```
