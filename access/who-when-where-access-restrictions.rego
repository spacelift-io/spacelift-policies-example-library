package spacelift

# In case things go wrong, we want you to be there.
#
# You know when things go wrong it's usually because someone did something. 
# Like an infra deployment. Let's try to make sure they're in the office 
# when doing so and restrict write access to business hours and office IP range. 
# This policy is best combined with one that gives read access.

# Let's set some variables we can reference later
now := input.request.timestamp_ns

clock := time.clock([now, "America/Los_Angeles"])

weekend := {"Saturday", "Sunday"}

weekday := time.weekday(now)

ip := input.request.remote_ip

# Now let's define use those above variables to define the criteria
# for who can have write access, when, and from where (the ip)
# 
# Allow write access from the Product team
write {
	input.session.teams[_] == "Product team"
}

# Only allow access during weekdays
deny_write {
	weekend[weekday]
}

# Only allow access during 9-5 time zone
deny_write {
	clock[0] < 9
}

deny_write {
	clock[0] > 17
}

# Only allow access from the 12.34.56.0/24 CIDR
deny_write {
	not net.cidr_contains("12.34.56.0/24", ip)
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
