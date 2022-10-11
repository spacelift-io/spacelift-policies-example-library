package spacelift

# This policy requires the following permissions on your VCS provider:
# - Read access to `issues` repository permissions
# - Subscribe to `issues:comments` event
# These are likely to be set already. If so, no action is needed.
#
# Assuming the above permissions are configured on your VCS application,
# you can then access pull request comment event data from within your Push policy,
# and build customizable workflows using this data.
#
# Please note that Spacelift will only evaluate comments that begin with`/spacelift`
# to prevent users from unintended actions against their resources managed by Spacelift.
# Furthermore, Spacelift only processes event data for new comments,
# and will not receive event data for edited or deleted comments.

track {
	input.pull_request.action == "commented"
	input.pull_request.comment == concat(" ", ["/spacelift", "deploy", input.stack.id])
}
