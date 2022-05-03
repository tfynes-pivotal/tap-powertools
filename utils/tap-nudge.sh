#!/bin/bash

function tap-nudge {
        TAPNS=tap-install
        kubectl -n $TAPNS patch packageinstalls.packaging.carvel.dev $1 --type='json' -p '[{"op": "add", "path": "/spec/paused", "value":true}]}}'
        kubectl -n $TAPNS patch packageinstalls.packaging.carvel.dev $1 --type='json' -p '[{"op": "add", "path": "/spec/paused", "value":false}]}}'
}

tap-nudge
