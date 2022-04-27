package spacelift

test_reject_public_worker {
    reject with input as {
        "stack": {
            "worker_pool": {
                "public": true
            }
        }
    }
}

test_reject_private_worker {
    not reject with input as {
        "stack": {
            "worker_pool": {
                "public": false
            }
        }
    }
}

test_approve_public_worker {
    not approve with input as {
        "stack": {
            "worker_pool": {
                "public": true
            }
        }
    }
}

test_approve_private_worker {
    approve with input as {
        "stack": {
            "worker_pool": {
                "public": false
            }
        }
    }
}
