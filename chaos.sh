#!/usr/bin/env bash

if [ $1 == "500" ]; then

    POD=$(kubectl -n demo2 get pod | grep catalog | awk '{ print $1 }')
    echo $POD

    for p in $POD; do
        if [ ${2:-"false"} == "delete" ]; then
            echo "Deleting 500 rule from $p"
            kubectl -n demo2 exec -c catalog -it $p -- curl  -X POST -H "Content-Type: application/json" -d '{"active":
        false,  "type": "500"}' localhost:3000/blowup
        else
            PERCENTAGE=${2:-100}
            kubectl -n demo2 exec -c catalog -it $p -- curl  -X POST -H "Content-Type: application/json" -d '{"active":
            true,  "type": "500",  "percentage": '"${PERCENTAGE}"'}' localhost:3000/blowup
            echo ""
        fi
    done


fi
