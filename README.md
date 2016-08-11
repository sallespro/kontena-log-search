# Kontena Log Search

kontena-log-search streams logs from Kontena Master MongoDB to Elasticsearch

docker build -t opens/kontena-log-search:latest github.com/sallespro/kontena-log-search.git


## Test Run - not as CoreOs Service

docker run --name=kontena-log-search --link kontena-server-mongo:mongodb -e MONGODB_URL=mongodb://mongodb/kontena_server -e ES_HOST=elastic.opens-dev.kontena.local -e ES_HOST=elastic.open-grid.kontena.local -e ES_PORT=9200 -e ES_INDEX=fluentd -e ES_TYPE=fluentd opens/kontena-log-search:latest 

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