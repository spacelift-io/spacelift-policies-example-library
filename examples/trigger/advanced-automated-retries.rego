package spacelift

# This import is required for Rego v0 compatibility and can be removed if you are only using Rego v1.
import rego.v1

# set the maximum number of retries
default max_retries := 3

# label to use for stack specific retries
default retry_count_key := "spacelift_retry"

# FN: gets the value of an array of retry labels
obtain_retries_count(arr) := {x |
	new_arr := array.concat(arr, [sprintf("%s:0", [retry_count_key])])
	some i
	parts := split(new_arr[i], ":")
	parts[0] == retry_count_key
	x := to_number(parts[1])
}

# Get the value of the highest retry stack label
retry_label := max(obtain_retries_count(input.stack.labels))

# Set the flag for the next iteration
new_retries := max(obtain_retries_count(input.run.flags)) + 1

retry_flag := sprintf("%s:%d", [retry_count_key, new_retries])

flag contains retry_flag

is_failed_and_tracked if {
	input.run.state == "FAILED"
	input.run.type == "TRACKED"
}

# trigger the stack if the max retry label is 0
trigger contains stack.id if {
	stack := input.stack
	is_failed_and_tracked
	retry_label <= 0
	new_retries <= max_retries
}

# trigger the stack if the max retry label is defined but only up to the maximum retries
trigger contains stack.id if {
	stack := input.stack
	is_failed_and_tracked
	retry_label > 0
	new_retries <= retry_label
	new_retries <= max_retries
}
