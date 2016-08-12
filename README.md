# Kontena Log Search

kontena-log-search streams logs from Kontena Master MongoDB to Elasticsearch

docker build -t opens/kontena-log-search:latest github.com/sallespro/kontena-log-search.git


## Test Run - not as CoreOs Service

docker run --name=kontena-log-search --link kontena-server-mongo:mongodb -e MONGODB_URL=mongodb://mongodb/kontena_server -e ES_HOST=conector.opens.com.br/elastic -e ES_PORT=9200 -e ES_INDEX=fluentd -e ES_TYPE=fluentd opens/kontena-log-search:latest


StdOut

docker run --name=kontena-log-search --link kontena-server-mongo:mongodb -e MONGODB_URL=mongodb://mongodb/kontena_server opens/kontena-log-search:latest

fluentd-stdout


## Environment

CoreOS Kontena Master Server + Grid Service of Elasticsearch:latest

## Local Installation to Kontena Master

- copy `kontena-log-search.service` file to master host folder `/etc/systemd/system/`
- write following environment values with correct values to
`/etc/kontena-log-search.env`:


- create capped collection to mongo for tracking log tail:

```
$ docker exec -it kontena-server-mongo mongo --eval 'db.createCollection("container_logs_tail", {capped: true, size: 5242880})' localhost/kontena_server
```

- reload systemd config

```
$ sudo systemctl daemon-reload
```

- start log archiver service

```
$ sudo systemctl start kontena-log-archiver
```

## License

Kontena software is open source, and you can use it for any purpose, personal or commercial. Kontena is licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) for full license text.

example

2016-05-20 21:52:43 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:43.567972 #1]  INFO -- Kontena::Workers::QueueWorker: stopped processing of msg queue","_id_str":"573f872df79260fb5a5446e3"}
2016-05-20 21:52:43 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:43.568328 #1]  INFO -- Kontena::Workers::LogWorker: stopped log streaming","_id_str":"573f872df79260fb5a5446e4"}
2016-05-20 21:52:43 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:43.576010 #1]  INFO -- Kontena::WebsocketClient: connection closed with code: 1006","_id_str":"573f872df79260fb5a5446e5"}
2016-05-20 21:52:43 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:43.567972 #1]  INFO -- Kontena::Workers::QueueWorker: stopped processing of msg queue","_id_str":"573f872df79260fb5a5446e6"}
2016-05-20 21:52:43 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:43.568328 #1]  INFO -- Kontena::Workers::LogWorker: stopped log streaming","_id_str":"573f872df79260fb5a5446e7"}
2016-05-20 21:52:43 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:43.576010 #1]  INFO -- Kontena::WebsocketClient: connection closed with code: 1006","_id_str":"573f872df79260fb5a5446e8"}
2016-05-20 21:52:44 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:44.356599 #1]  INFO -- Kontena::WebsocketClient: connecting to master","_id_str":"573f872df79260fb5a5446e9"}
2016-05-20 21:52:44 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:44.754331 #1]  INFO -- Kontena::WebsocketClient: connection established","_id_str":"573f872df79260fb5a5446ea"}
2016-05-20 21:52:44 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:44.939035 #1]  INFO -- Kontena::Workers::QueueWorker: started to process msg queue","_id_str":"573f872df79260fb5a5446eb"}
2016-05-20 21:52:44 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:44.939215 #1]  INFO -- Kontena::Workers::NodeInfoWorker: publishing node information","_id_str":"573f872df79260fb5a5446ec"}
2016-05-20 21:52:44 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:44.959786 #1]  INFO -- Kontena::Workers::LogWorker: started log streaming","_id_str":"573f872ef79260fb5a5446ed"}
2016-05-20 21:52:46 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:45.936799 #1]  INFO -- Kontena::NetworkAdapters::Weave: router started with peers 192.168.0.104, 192.168.0.185, 192.168.0.184, 192.168.0.170","_id_str":"573f872ff79260fb5a5446ee"}
2016-05-20 21:52:46 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:46.355155 #1]  INFO -- Kontena::NetworkAdapters::Weave: bridge exposed: 10.81.0.1/19","_id_str":"573f872ff79260fb5a5446ef"}
2016-05-20 21:52:46 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:46.383327 #1]  INFO -- Kontena::Workers::WeaveWorker: attaching network to existing containers","_id_str":"573f8730f79260fb5a5446f0"}
2016-05-20 21:52:46 +0000 weave: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8515038158000700febf"},"type":"stderr","data":"INFO: 2016/05/20 21:52:46.462200 [nameserver ea:70:29:64:8f:54] adding entry for b78e5357bcc3da613b4c9e3cb0af642b7233d32213c0b97178dcad2fb2416c63: load-load-1.kontena.local. -> 10.81.1.204","_id_str":"573f8730f79260fb5a5446f1"}
2016-05-20 21:52:46 +0000 kontena-agent: {"grid_id":{"$oid":"572a626be5f72f000600000c"},"host_node_id":"572a6300e5f72f0006001ed0","grid_service_id":null,"container_id":{"$oid":"573f8509038158000700febc"},"type":"stdout","data":"I, [2016-05-20T21:52:46.457284 #1]  INFO -- Kontena::Launchers::Etcd: etcd is already running","_id_str":"573f8732f79260fb5a5446f2"}