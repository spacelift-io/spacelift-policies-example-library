package spacelift

import future.keywords

# Note:  This policy requires the configuration of your terraform state to be provided.  In this policy,
# we reference this via `input.third_party_metadata.custom.configuration` (line 56 below)
# which is provided to the policy if you follow the instructions documented here:
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy#example-exposing-terraform-configuration-to-the-plan-policy

# TODO:  Upgrade to take into account approved versions of the approved modules, and implement 
# ability to warn on deprecated versions, and deny on no longer supported versions!

# This is a map of resource types and the list of modules which are
# approved to be used to create them.  Note, you do not need to allow explicitly 
# any "wrapper" modules... this is checking the immediate module parent of the resource itself
# Some example resources and approved module(s), you of course can specify your spacelift.io hosted modules
controlled_resource_types = {
  "aws_s3_bucket": ["terraform-aws-modules/s3-bucket/aws"],
  "aws_s3_bucket_acl": ["terraform-aws-modules/s3-bucket/aws"],
  "aws_s3_bucket_website_configuration": ["terraform-aws-modules/s3-bucket/aws"]
}

# Deny ability to create the resource directly (aka not in a module we identify)
deny[reason] {
  resource := input.terraform.resource_changes[_]
  actions := {"create", "update"}
  actions[resource.change.actions[_]]
  module_source = controlled_resource_types[resource.type]
  not resource.module_address
  reason := sprintf(
      "Resource '%s' cannot be created directly. Module(s) '%s' must be used instead",
      [resource.address, concat("', '", controlled_resource_types[resource.type])]
  )
}

# Deny ability to create the resource in an unapproved module
deny[failed_reasons] {
  # Did any of the resources fail to pass?
  count(invalid_resources[_]) > 0

  # Build a list of reasons for each failure
  failed_reasons := [ sprintf(
      "Resource '%s' in top level module named '%s' is being created with the incorrect terraform module '%s'. Module(s) '%s' must be used instead.",
      [reason.resource_type, reason.top_level_module_name, reason.resource_module_name, concat("', '", controlled_resource_types[reason.resource_type])]) | reason := invalid_resources[_]][_]
}

has_key(x, k) { _ = x[k] }

contains_value(list, elem) {
  list[_] = elem
}

# Walk the "configuration" tree and find all the resources which appear in our
# "controlled_resource_types"
controlled_resources[resource] {
  # Recursively walk the module hierarchy
  [path, module_ref] := walk(input.third_party_metadata.custom.configuration)

  # Filter out only objects that are modules, i.e. have a source property
  source := module_ref["source"]

  # Get all resources created in the module and their types
  resources := module_ref["module"]["resources"]
  resource_type := resources[_]["type"]

  # Filter out resources that are considered controlled
  has_key(controlled_resource_types, resource_type)

  # Create an object with the module and the resource type,
  # this is a set so duplicates will be removed based on this object
  resource := {
    "resource_module_name": source,
    "top_level_module_name": path[2],
    "resource_type": resource_type,
    "resource_module_version_constraint": module_ref["version_constraint"]
  }
}

# When the controlled resources are collected, iterate through them and
# see if they comply
invalid_resources[failed] {
  failed := [ resource_instance | resource_instance := controlled_resources[_]; not resource_instance.resource_module_name in controlled_resource_types[resource_instance.resource_type] ][_]
}
