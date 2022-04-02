# Spacelift Policies Example Library

This repository contains a collection of Spacelift Policy examples that can be re-purposed (if needed), and used with [Spacelift](https://spacelift.io/). Spacelift Policies use the Open Policy Agent, which are written in the rego language. As you'll find in this repository, there are various types of Spacelift Policies - which allow for a lot of flexibility and customization. For more information on Spacelift Policies please refer to the [documentation](https://docs.spacelift.io/concepts/policy).

## Useful resources

* [Spacelift Policies](https://docs.spacelift.io/concepts/policy): You can find information about all available Spacelift Policy types here.
* [Open Policy Agent](https://www.openpolicyagent.org/docs/latest/policy-language/): Spacelift Policies utilize the Open Policy Agent, which uses the Rego language.
* [Spacelift Policy Workbench](https://docs.spacelift.io/concepts/policy#policy-workbench): Use the Spacelift Policy Workbench to debug your policies using sample policy inputs.
* [Testing Policies](https://docs.spacelift.io/concepts/policy#testing-policies): Learn about creating test cases for your Spacelift Policies.

## Policy Examples by Category

Policy Types Currently In This Library are below. Feel free to click on a given policy type to be taken to examples for that policy type.

| Policy Type | Description |
| ------------- | ------------- |
| [ACCESS](./access/)  | Define who gets to access individual Stacks and with what level of access. |
| [APPROVAL](./approval)  | Define who can approve or reject a run/task and how a run/task can be approved. |
| [LOGIN](./login)  | Define who gets to login to your Spacelift account and with what level of access.|
| [PLAN](./plan)  | Define which changes can be applied. |
| [PUSH](./push/)  | Define how git push events are interpreted. |
| [TRIGGER](./trigger)  | Define what happens when blocking runs terminate. |

## All Policy Examples

| Policy Type | Policy Name |
| ------------- | ------------- |
| [ACCESS](./access/)  | [Engineering Team Access](./access/engineering-team-access.rego) |
| [ACCESS](./access/)  | [Protect Administrative Stacks](./access/protect-administrative-stacks.rego) |
| [ACCESS](./access/)  | [Slack Channel Access](./access/slack-channel-access.rego) |
| [ACCESS](./access/)  | [Who When Where Access Restrictions](./access/who-when-where-access-restrictions.rego) |
| [APPROVAL](./approval)  | [Allowlist Task Commands](./approval/allowlist-task-commands.rego) |
| [APPROVAL](./approval)  | [Multi Team Required Approvals](./approval/multi-team-required-approvals.rego) |
| [APPROVAL](./approval)  | [Task and Run Approvals](./approval/task-and-run-approvals.rego) |
| [APPROVAL](./approval)  | [Two Approvals No Rejections](./approval/two-approvals-no-rejections.rego) |
| [LOGIN](./login)  | [DevOps Team are Admins](./login/devops-are-admins.rego) |
| [LOGIN](./login)  | [External Contributor Access](./login/external-contributor-access.rego) |
| [LOGIN](./login)  | [Rewriting User Teams](./login/rewriting-user-teams.rego) |
| [LOGIN](./login)  | [Who When Where Login Restrictions](./login/who-when-where-login-restrictions.rego) |
| [PLAN](./plan)  | [Don't Allow Resource Type](./plan/dont-allow-resource-type.rego) |
| [PLAN](./plan)  | [Enforce Password Strength](./plan/enforce-password-length.rego) |
| [PLAN](./plan)  | [Enforce Tags on Resources](./plan/enforce-tags-on-resources.rego) |
| [PLAN](./plan)  | [Infracost Monthly Cost Restriction](./plan/infracost-monthly-cost-restriction.rego) |
| [PUSH](./push/)  | [Cancel In Progress Runs](./push/cancel-in-progress-runs.rego) |
| [PUSH](./push/)  | [Create Proposed Run From PR Label](./push/create-proposed-run-from-env-pr-labels.rego) |
| [PUSH](./push/)  | [Ignore Changes Outside Root](./push/ignore-changes-outside-root.rego) |
| [PUSH](./push/)  | [Terragrunt Monorepo Ignore Changes Outside Root](./push/terragrunt-monorepo-ignore-changes-outside-root.rego) |
| [TRIGGER](./trigger)  | [Automated Retries](./trigger/automated-retries.rego) |
| [TRIGGER](./trigger)  | [Trigger Dependencies](./trigger/trigger-dependencies.rego) |

## Policy Tests

Tests can be added for policies using the convention `<policy_filename>_test.rego`. For example
if you have a policy called `plan.rego`, you can create a test file called `plan_test.rego`.

You can use the following command to run all policy tests:

```shell
./run_policy_tests.sh
```
