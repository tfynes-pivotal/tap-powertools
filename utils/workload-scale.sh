#!/bin/bash

function workload-scale {
        DEVNS=default
        kubectl -n $DEVNS patch workload.carto.run $1 --type='json' -p '[{"op": "add", "path": "/spec/paused", "value":true}]}}'
        kubectl -n $TAPNS patch packageinstalls.packaging.carvel.dev $1 --type='json' -p '[{"op": "add", "path": "/spec/paused", "value":false}]}}'
}

workload-scale
