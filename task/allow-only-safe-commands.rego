package spacelift

# This task policy only allows you to exectute a few selected commands.
#
# You can read more about task policies here:
#
# https://docs.spacelift.io/concepts/policy/task-run-policy

allowlist := {
    "ls",
    "terraform taint random_password.secret",
}

allowed { allowlist[_] == input.request.command }
deny["Only selected commands are allowed"] { not allowed }

# Learn more about sampling policy evaluations here:
#
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample { true }
