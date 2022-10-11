package spacelift

# When things go wrong it's usually because someone did something, like an infra deployment.
# Let's try to make sure they're in the office when doing so and restrict write access to business hours
# and office IP range.
#
# This policy is best combined with one that gives read access.

now := input.request.timestamp_ns

clock := time.clock([now, "America/Los_Angeles"])

weekend := {"Saturday", "Sunday"}

weekday := time.weekday(now)

ip := input.request.remote_ip

write {
	input.session.teams[_] == "Product team"
}

deny_write {
	weekend[weekday]
}

deny_write {
	clock[0] < 9
}

deny_write {
	clock[0] > 17
}

deny_write {
	not net.cidr_contains("12.34.56.0/24", ip)
}
