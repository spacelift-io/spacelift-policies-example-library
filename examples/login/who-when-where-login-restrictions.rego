package spacelift

# The example below is pretty extreme but it shows a very comprehensive
# policy where you restrict Spacelift access to users logging in from the office IP
# during business hours. You may want to use elements of this policy to create your own
# - less draconian - version, or keep it this way to support everyone's work-life balance.

# Let's set some variables we can reference later
now := input.request.timestamp_ns

clock := time.clock([now, "America/Los_Angeles"])

weekend := {"Saturday", "Sunday"}

weekday := time.weekday(now)

ip := input.request.remote_ip

# Now let's define use those above variables to define the criteria
# for who can have write access, when, and from where (the ip)
#
# Only allow access during weekdays
deny {
	weekend[weekday]
}

# Only allow access during 9-5 time zone
deny {
	clock[0] < 9
}

deny {
	clock[0] > 17
}

# Only allow access from the 12.34.56.0/24 CIDR
deny {
	not net.cidr_contains("12.34.56.0/24", ip)
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample := true
