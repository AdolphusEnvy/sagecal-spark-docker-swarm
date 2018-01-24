networkpre:
	docker network create --ingress --driver overlay ingress
network:
	docker network create -d overlay --attachable spark-net

spark:
	docker stack deploy -c spark-swarm.yml spark

spark-scale:
	docker service scale spark_worker=4

services:
	docker stack deploy -c docker-compose-services.yml services

stop:
	docker stack rm spark
	docker stack rm hadoop

ip:
	docker network inspect docker_gwbridge | egrep 'Name|IPv4Address'
