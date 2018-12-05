#!/bin/bash

echo '------------------------------------------------------------------------------------'
echo 'CONTAINERS'
docker ps --format "table {{.Names}}\t {{.Ports}}"


echo '------------------------------------------------------------------------------------'
echo 'IP Addresses'
# for service in $(docker service ls -q);
# do
#     docker service ps $service -q --filter "desired-state=Running" | xargs docker inspect --format '{{range .NetworksAttachments}}{{.Addresses}}{{end}}';
# done
docker inspect -f '{{.Name}}  {{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' $(docker ps -aq)


echo '------------------------------------------------------------------------------------'
echo 'STACKS'
stacks=( 'spark' 'minio' 'vis' )
for stackName in "${stacks[@]}"
do
    echo ''
    docker stack ps --format 'table {{.ID}}\t{{.Name}}\t{{.Node}}\t{{.CurrentState}}' $stackName
done
