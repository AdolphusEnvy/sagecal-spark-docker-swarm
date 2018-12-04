# SageCal on Apache Spark (WIP)

## About

The Docker swarm cluster with Apache Spark and HDFS filesystem to run [SageCal](https://github.com/nlesc-dirac/sagecal). The setup uses [Docker images](https://github.com/nlesc-dirac/spark-archsci-images) to build scaleble cluster.


## Included Software
| Name    | Version   |
| ------- | --------- |
| Minio   |           |
| Spark   | 2.2.0     |
| java    | OpenJDK-8 |
| SageCal | -         |

**Note:** The setup was only tested on Linux64 system.

## Docker images

docker pull fdiblen/spark-worker-dirac
docker pull fdiblen/spark-master-dirac


## Instructions

Intallation instructions [SETUP.md](docs/SETUP.md)

Instructions to submit a job [JOBS.md](docs/JOBS.md)
