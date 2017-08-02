### elas集群搭建
```
cluster.name: elasticsearch
node.name: elas1
node.master: true
network.host: 0.0.0.0
http.port: 9200
network.publish_host: 10.26.92.178
discovery.zen.ping.unicast.hosts: ["10.26.92.178","10.26.250.63"]
#path.data: /path/to/data1,/path/to/data2

cluster.name: elasticsearch
node.name: elas2
node.master: false
network.host: 0.0.0.0
http.port: 9200
network.publish_host: 10.26.250.63
discovery.zen.ping.unicast.hosts: ["10.26.92.178","10.26.250.63"]


nohup logstash -f elk_up.conf &> /dev/null &
nohup logstash -f elk_down.conf &> /dev/null &
nohup logstash -f elk_re_down.conf &> /dev/null &


docker run -d -p 9200:9200 -p 9300:9300 -v /data/elas_data/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /data/elas_data:/usr/share/elasticsearch/data -v /data/elas_plugins:/usr/share/elasticsearch/plugins --name elas elasticsearch:5.3.2

-v /data/elas_data:/usr/share/elasticsearch/data
-v /data/elas_data/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml

nohup command &> /dev/null &

nginx auth conf
docker pull nginx
docker run --name nginx -v /home/data/nginx/conf.d:/etc/nginx/conf.d -v /home/projects:/projects -p 80:80 -d nginx
```
### 节点加新磁盘
```
docker run -d -p 9200:9200 -p 9300:9300 -v /esdata/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /data/elas_data:/usr/share/elasticsearch/data -v /esdata/es_data2:/usr/share/elasticsearch/data2 -v /esdata/elas_plugins:/usr/share/elasticsearch/plugins --name elas-slave1 elasticsearch:5.3.2

```