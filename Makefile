networkpre:
	docker network create --ingress --driver overlay ingress
network:
	docker network create -d overlay --attachable spark-net

start:
	docker stack deploy -c spark-swarm.yml spark

scale:
	docker service scale spark_worker=4

info:
	@echo
	docker stack ls
	@echo
	@echo
	docker stack services spark

stop:
	docker stack rm spark
	docker stack rm hadoop

ip:
	docker network inspect docker_gwbridge | egrep 'Name|IPv4Address'
