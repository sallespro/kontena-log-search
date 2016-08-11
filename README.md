# Cloud Log Search

Cloud Log Search streams logs from Kontena Master MongoDB to Elasticsearch

docker build https://raw.githubusercontent.com/sallespro/kontena-log-search/Dockerfile

## Environment

CoreOS Master Server - Service

[Unit]
Description=kontena-log-search
After=network-online.target
After=docker.service
Description=kontena-log-search
Documentation=https://github.com/sallespro/kontena-log-search
Requires=network-online.target
Requires=docker.service
Requires=kontena-server-mongo.service

[Service]
Restart=always
RestartSec=5
EnvironmentFile=/etc/kontena-log-search.env
ExecStartPre=/usr/bin/docker pull opens/kontena-log-search:latest
ExecStartPre=-/usr/bin/docker stop kontena-log-search
ExecStartPre=-/usr/bin/docker rm kontena-log-search
ExecStart=/usr/bin/docker run --name=kontena-log-search \
    --link kontena-server-mongo:mongodb \
    -e MONGODB_URL=mongodb://mongodb/kontena_server \
    opens/kontena-log-search:latest
ExecStop=/usr/bin/docker stop kontena-log-search



ES_HOST=elastic.opens-dev.kontena.local
ES_PORT=9200
ES_INDEX=fluentd
ES_TYPE=fluentd

opens-dev/elastic:
  status: running
  image: elasticsearch:latest
  stateful: yes
  scaling: 1
  strategy: ha
  deploy_opts:
    min_health: 0.8
  dns: elastic.opens-dev.kontena.local
  affinity:
    - bitter-flower-2
  env:
    - KONTENA_LB_INTERNAL_PORT=9200
    - KONTENA_LB_VIRTUAL_HOSTS=conector.opens.com.br
    - KONTENA_LB_VIRTUAL_PATH=/elastic
  net: bridge
  ports:
    - 9200:9200/tcp
  links:
    - load-load
  instances:
    elastic-1:
      rev: 2016-05-12 19:01:03 UTC
      node: nameless-shadow-31
      dns: elastic-1.opens-dev.kontena.local
      ip: 10.81.1.169
      public ip: 54.207.127.57
      status: running
      
      

## a quick overview of collections - kONTENA mASTER

> use kontena_server
switched to db kontena_server

> show collections;
access_tokens
audit_logs
container_logs
container_stats
containers
distributed_locks
grid_secrets
grid_service_deploys
grid_services
grid_stats
grids
host_node_stats
host_nodes
images
overlay_cidrs
pubsub_channels
registries
roles
schema_migrations
system.indexes
users
