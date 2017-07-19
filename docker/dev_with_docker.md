### 开发遇上docker
```
mysql:
  docker run --name mysql -p 3306:3306 -v /sun/docker_data/mysql:/sun -e MYSQL_ROOT_PASSWORD=... -d mysql:latest
  docker run -d --name mysql -v /tmp/db:/var/lib/mysql -p 3309:3306 -e MYSQL_ROOT_PASSWORD=... mysql
postgres:
  docker run --name postgres -p 5432:5432 -v /sun/docker_data/postgres:/sun -e POSTGRES_PASSWORD=... -d postgres:latest
redis:
  docker run -p 6379:6379 -v /sun/docker_data/redis:/sun -v /sun/docker_data/redis/redis.conf:/usr/local/etc/redis/redis.conf --name redis -d redis:latest redis-server /sun/redis.conf
rails5:
  docker run -t -i -p 3000:3000 -v /sun/phantom/rails5:/sun/rails5 --name rails5 -d rails:latest /bin/bash
rails:
  docker run -t -i -p 3000:3000 -v /sun:/sun --name rails -d rails:latest /bin/bash
golang:
  docker run -t -i -p 8899:8899 -v /sun/go:/go --name golang -d golang:latest /bin/bash
  docker run -t -i -p 9999:9999 -v /sun/go:/go --name golang -d golang:latest /bin/bash
gogs:
  docker run -t -i -p 10022:22 -p 10080:3000 -v /sun/phantom/gogs:/data --name=gogs gogs/gogs
birt:
  docker run -t -i --name birt -p 9000:8080 -v /sun/birt:/var/lib/tomcat7/webapps/birt/reports -d lavadiablo/docker-birt-host
memcached:
  docker run --name memcached -p 11211:11211 -d memcached:latest
storm:
  docker run -t -i -p 6666:6666 -v /sun/phantom/storm:/sun/storm --name storm -d storm:latest /bin/bash
java:
  docker run -t -i -p 8888:8888 -v /sun/phantom/storm:/sun/storm --name java -d java:latest /bin/bash
jruby:
  docker run -t -i -p 6666:6666 -v /sun/jruby:/sun/jruby --name jruby -d jruby:latest /bin/bash
caravel:
  docker run --name caravel -d -p 8088:8088 amancevice/caravel
  docker exec -it caravel demo
python2:
  docker run -t -i -p 8001:8001 -v /sun:/sun --name python2 -d python:2.7.13 /bin/bash
python3:
  docker run -t -i -p 8002:8002 -v /sun:/sun --name python2 -d python:3.6.0 /bin/bash
data_science:
  docker run -t -i -p 8003:8003 -v /sun:/sun --name data_science -d appsecco/data-science-toolbox /bin/bash
mssql:
  docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=sun' -p 1433:1433 -d microsoft/mssql-server-linux
hadoop:
  docker run -it -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 50090:50090 -p 19888:19888 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8040:8040 -p 8042:8042 -p 8088:8088 -p 49707:49707 -p 2122:2122 -v /sun:/sun --name hadoop -d sequenceiq/hadoop-docker:latest /etc/bootstrap.sh -bash
cloudera:
  docker run -t -i -v /sun:/sun --name cloudera -d caioquirino/docker-cloudera-quickstart /bin/bash
logstash:
  docker run -i -t -v /sun/logstash:/logstash --net=hadoop --name logstash -d logstash /bin/bash
elasticsearch:
  docker run -d -p 9200:9200 -p 9300:9300 --name elas elasticsearch:5.3.2 -Etransport.host=0.0.0.0 -Ediscovery.zen.minimum_master_nodes=1
kibana:
  docker run --name kibana -e ELASTICSEARCH_URL=http://172.28.128.7:9200 -p 5601:5601 -d kibana
  docker run --name kibana -e ELASTICSEARCH_URL=http://10.26.92.178:9200 -p 5601:5601 -d kibana
  docker run --name kibana -e ELASTICSEARCH_URL=http://192.168.16.6:9200 -p 5601:5601 --net=hadoop -d kibana
Grafana:
  docker run --name grafana -p 3000:3000 -d grafana/grafana
timescaledb:
  docker run -d \
  --name timescaledb \
  -v /home/vagrant/elas/timescaledb:/var/lib/postgresql/data \
  -p 5432:5432 \
  -e PGDATA=/var/lib/postgresql/data/timescaledb \
  timescale/timescaledb postgres \
  -cshared_preload_libraries=timescaledb

neo4j:
  docker run -d -p 7474:7474 -p 7687:7687 -v /sun/docker_data/neo4j:/data --name neo4j neo4j
cassandra:
  docker run --name cassandra -v /sun/docker_data/cassandra:/var/lib/cassandra -d cassandra
  docker run --name cassandra -d cassandra






docker export <container id> > /sun/docker_data/docker_image/dev_golang_image_20161127.tar






docker run -d --name mysql -v /data/mysql_db:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=. mysql

docker run -p 6378:6379 --name redis -d redis:latest

```