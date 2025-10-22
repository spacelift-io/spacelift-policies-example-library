package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# Extract the UTC hour from the provided timestamp and declare our variables.
utc_hour := time.clock(input.run.created_at)[0]

weekend := {"Saturday", "Sunday"}

weekday := time.weekday(utc_hour)

# If it's before 9am or after 5pm or earlier UTC, automatically approve
approve if {
	utc_hour >= 9
	utc_hour <= 17
	weekday
}

# If it's before 9am or after 5pm UTC, require at least one approval and no rejections.
approve if {
	utc_hour > 17
	count(input.reviews.current.approvals) >= 1
}

approve if {
	utc_hour < 9
	count(input.reviews.current.approvals) >= 1
}

# require approval access during weekdays
approve if {
	weekend[weekday]
	count(input.reviews.current.approvals) >= 1
}

reject if {
	count(input.reviews.current.rejections) > 0
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
