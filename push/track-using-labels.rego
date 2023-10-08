package spacelift

track {
	input.push.branch == input.stack.branch
	affected
}

propose {
	input.push.branch != ""
}

ignore {
	not affected
}

# Extract and use tracked directories and extensions from labels
tracked_directories[tracked_directory] {
	label := input.stack.labels[_]
	startswith(label, "trackeddirectories:")
	tracked_directory := split(label, ":")[1]
}

tracked_extensions[tracked_extension] {
	label := input.stack.labels[_]
	startswith(label, "trackedextensions:")
	tracked_extension := split(label, ":")[1]
}

affected {
	some i, j
	path := input.push.affected_files[i]
	startswith(path, tracked_directories[j])
}

affected {
	some i, j
	path := input.push.affected_files[i]
	endswith(path, tracked_extensions[j])
}

sample = true