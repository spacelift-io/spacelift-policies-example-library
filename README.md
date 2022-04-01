# Spacelift Policies Example Library

This repository contains a collection of Spacelift Policy examples that can be re-purposed (if needed), and used with [Spacelift](https://spacelift.io/). Spacelift Policies use the Open Policy Agent, which are written in the rego language. As you'll find in this repository, there are various types of Spacelift Policies - which allow for a lot of flexibility and customization. For more information on Spacelift Policies please refer to the [documentation](https://docs.spacelift.io/concepts/policy).

## Useful resources

* [Spacelift Policies](https://docs.spacelift.io/concepts/policy): You can find information about all available Spacelift Policy types here.
* [Open Policy Agent](https://www.openpolicyagent.org/docs/latest/policy-language/): Spacelift Policies utilize the Open Policy Agent, which uses the Rego language.
* [Spacelift Policy Workbench](https://docs.spacelift.io/concepts/policy#policy-workbench): Use the Spacelift Policy Workbench to debug your policies using sample policy inputs.
* [Testing Policies](https://docs.spacelift.io/concepts/policy#testing-policies): Learn about creating test cases for your Spacelift Policies.

## Policy Examples by Category

Policy Types Currently In This Library are below. Feel free to click on a given policy type to be taken to examples for that policy type.

| Policy Type |
| ------------- |
| [ACCESS](./access/)  |
| [APPROVAL](./approval)  |
| [PUSH](./push/)  |
| [LOGIN](./login)  |
| [PLAN](./plan)  |
| [TASK](./task)  |
| [TRIGGER](./trigger)  |

## All Policy Examples

| Policy Type | Policy Name |
| ------------- | ------------- |
| [ACCESS](./access/)  | [Engineering Team Access](./access/engineering-team-access.rego) |
| [ACCESS](./access/)  | [Slack Channel Access](./access/slack-channel-access.rego) |
| [APPROVAL](./approval)  | [Multi Team Required Approvals](./approval/multi-team-required-approvals.rego) |
| [PUSH](./push/)  | [Create Proposed Run From PR Label](./push/create-proposed-run-from-env-pr-labels.rego) |
| [PUSH](./push/)  | [Ignore Changes Outside Root](./push/ignore-changes-outside-root.rego) |
| [PUSH](./push/)  | [Terragrunt Monorepo Ignore Changes Outside Root](./push/terragrunt-monorepo-ignore-changes-outside-root.rego) |
| [LOGIN](./login)  | [DevOps Team are Admins](./login/devops-are-admins.rego) |
| [PLAN](./plan)  | [Don't Allow Resource Type](./plan/dont-allow-resource-type.rego) |
| [PLAN](./plan)  | [Enforce Password Strength](./plan/enforce-password-length.rego) |
| [PLAN](./plan)  | [Enforce Tags on Resources](./plan/enforce-tags-on-resources.rego) |
| [PLAN](./plan)  | [Infracost Monthly Cost Restriction](./plan/infracost-monthly-cost-restriction.rego) |
| [TASK](./task)  | [Allow Only Safe Task Commands](./trigger/allow-only-safe-commands.rego) |
| [TRIGGER](./trigger)  | [Trigger Dependencies](./trigger/trigger-dependencies.rego) |

## Policy Tests

Tests can be added for policies using the convention `<policy_filename>_test.rego`. For example
if you have a policy called `plan.rego`, you can create a test file called `plan_test.rego`.

You can use the following command to run all policy tests:

```shell
./run_policy_tests.sh
```
