# Included Software
|  Name  | Version  |
|------- |--------- |
| Hadoop |   2.9    |
| Spark  |   2.2.0  |
| java   | OpenJDK-8|
| SageCal| -        |

The setup was only tested on Linux64 system.

# Deployment
## 1. Initialize swarm cluster
```bash
docker swarm init | tee swarm_output.txt
docker node ls
```

### Example output
```
docker swarm join --token SWMTKN-1-3gwp3macxbel3ww5l8rbrhos37gz3as22nuoiz8xr85ud7emn44-0opil6j70aq92vfi5hfx2dawp X.X.X.X:2377
```

## 2. Setup networks
```bash
docker network create --ingress --driver overlay ingress
docker network create -d overlay --attachable spark-net
```

## 3. Deploy swarm clusters
```bash
docker stack deploy --compose-file spark-swarm.yml spark
docker stack deploy --compose-file hadoop-swarm.yml hadoop
```

### 3.1. Check the status

To list existing stacks:
```bash
docker stack ls
```

To list the services:
```bash
docker stack services spark
docker stack services hadoop
```

To list the tasks:
```bash
docker stack ps spark
docker stack ps hadoop
```



## 4. Scale services (optional)
```bash
docker service scale spark_worker=2
```

## 5. Check the service status

http://0.0.0.0:8080


# Stopping (removing) the services
```bash
docker stack rm spark
docker stack rm hadoop
```

## To remove services (**needs to be checked**):
```bash
docker service rm spark_master rm spark_worker
docker service rm hadoop_datanode hadoop_namenode
```

# Leaving the swarm cluster
```bash
docker swarm leave --force
```


# Check service status
```bash
docker stack ls
docker stack services spark
docker service inspect --pretty  spark_master
docker service inspect --pretty  spark_worker
docker service ps spark_master
docker service ps spark_worker
```

## Check network
```bash
docker network inspect spark-net
```

## Check logs
```bash
docker service logs spark_worker
docker service logs spark_worker -t -f
```


## Get IP
```bash
docker network inspect docker_gwbridge | egrep 'Name|IPv4Address'
```

[](Comment
https://stackoverflow.com/questions/39237998/swarm-mode-inspect-worker-nodes-container-on-manager-node/39239097#39239097
)

```bash
docker service ls

docker service ps $SERVICE #(spark_spark-worker)

docker inspect --format "{{.Status.ContainerStatus.ContainerID}}" $ID #(sqaewrywf3rj)

docker inspect --format "{{.NetworkSettings.IPAddress}}" $RETURNED_ID #(13a24dff4bd1f9351938b09d32db451406ed64b5f890f66f18fec12c611e9175)
```



## Errors and Fixes
docker service logs jkba92hbimzo

  ### 1- Docker-systemd(>232)
  ```
  container_linux.go:295: starting container process caused "process_linux.go:399: container init caused \"process_linux.go:382: running prestart hook 0 caused \\\"fork/exec /usr/bin/dockerd (deleted): no such file or directory\\\"\""
  ```

  ### solution:
  https://github.com/opencontainers/runc/issues/1175
