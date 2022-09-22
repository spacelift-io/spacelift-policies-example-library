package spacelift

# In addition to boolean rules regulating access to your Spacelift account, the login
# policy exposes the team rule, which allows one to dynamically rewrite the list of teams
# received from the identity provider. This operation allows one to define Spacelift roles
# independent of the identity provider. To illustrate this use case, let's imagine you want
# to define a Superwriter role for someone who's:
# - logging in from an office VPN;
# - is a member of the DevOps team, as defined by your IdP;
# - is not a member of the Contractors team, as defined by your IdP;

team["Superwriter"] {
	office_vpn
	devops
	not contractor
}

contractor {
	input.session.teams[_] == "Contractors"
}

devops {
	input.session.teams[_] == "DevOps"
}

office_vpn {
	net.cidr_contains("12.34.56.0/24", input.request.remote_ip)
}

# What's important here is that the team rule overwrites the original list of teams, 
# meaning that if it evaluates to a non-empty collection, it will replace the original list
# of teams in the session. In the above example, the Superadmin role will become the only 
# team for the evaluated user session.

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample = true
