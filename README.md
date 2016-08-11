# Kontena Log Search

kontena-log-search streams logs from Kontena Master MongoDB to Elasticsearch

docker build -t opens/kontena-log-search:latest https://raw.githubusercontent.com/sallespro/kontena-log-search/Dockerfile 

## Environment

CoreOS Master Server - Service
+

Elasticsearch:latest

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