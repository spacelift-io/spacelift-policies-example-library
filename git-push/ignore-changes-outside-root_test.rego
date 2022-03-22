package spacelift

test_affected_no_files {
    not affected with input as {
        "stack": {
            "project_root": ""
        },
        "push": {
            "affected_files": []
        }
    }
}

test_affected_tf_files {
    affected with input as {
        "stack": {
            "project_root": ""
        },
        "push": {
            "affected_files": ["main.tf", "stacks.tf"]
        }
    }
}

test_affected_no_tf_files {
    not affected with input as {
        "stack": {
            "project_root": ""
        },
        "push": {
            "affected_files": ["README", "myicon.png"]
        }
    }
}

test_affected_outside_project_root {
    not affected with input as {
        "stack": {
            "project_root": "stacks/my-stack"
        },
        "push": {
            "affected_files": ["stacks/another-stack/main.tf"]
        }
    }
}

test_ignore_affected {
    ignore with affected as false
}

test_ignore_not_affected {
    not ignore with affected as true
}

test_ignore_tag {
    ignore with input as {
        "push": {
            "tag": "v1.0.0"
        }
    } with affected as true
}

test_propose_affected {
    propose with affected as true
}

test_propose_not_affected {
    not propose with affected as false
}

matching_branch_input = {
        "push": {
            "branch": "main"
        },
        "stack": {
            "branch": "main"
        }
    }

test_track_affected {
    track with input as matching_branch_input with affected as true
}

test_track_not_affected {
    not track with input as matching_branch_input with affected as false
}

test_track_not_stack_branch {
    not track with input as {
        "push": {
            "branch": "my-feature"
        },
        "stack": {
            "branch": "main"
        }
    } with affected as true
}
