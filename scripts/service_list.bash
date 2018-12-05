#!/bin/bash

stacks=( 'spark' 'minio' 'vis' )

for stackName in "${stacks[@]}"
do
    echo '------------------------------------------------------------------------------------'
    docker stack ps --format 'table {{.Name}}\t{{.Node}}\t{{.CurrentState}}' $stackName
done