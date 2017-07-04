cluster.name: elasticsearch
node.name: elas
node.master: true
network.host: 0.0.0.0
http.port: 9200
network.publish_host: 172.28.128.7
# discovery.zen.ping.unicast.hosts: ["10.26.92.178","10.26.250.63"]
path.data: /usr/share/elasticsearch/data#,/usr/share/elasticsearch/data2

docker run -d -p 9200:9200 -p 9300:9300 -v /home/vagrant/elas/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /home/vagrant/elas/data:/usr/share/elasticsearch/data -v /home/vagrant/elas/plugins:/usr/share/elasticsearch/plugins --name elas_old elasticsearch:5.3.2
docker run -d -p 9200:9200 -p 9300:9300 -v /home/vagrant/elas/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /home/vagrant/elas/data:/usr/share/elasticsearch/data -v /home/vagrant/elas/data2:/usr/share/elasticsearch/data2 -v /home/vagrant/elas/plugins:/usr/share/elasticsearch/plugins --name elas_new elasticsearch:5.3.2







elasticsearch-plugin install https://github.com/NLPchina/elasticsearch-sql/releases/download/5.3.2.0/elasticsearch-sql-5.3.2.0.zip

cluster.name: elasticsearch
node.name: elas1
node.master: true
network.host: 0.0.0.0
http.port: 9200
network.publish_host: 10.26.92.178
discovery.zen.ping.unicast.hosts: ["10.26.92.178","10.26.250.63"]
path.data: /usr/share/elasticsearch/data,/usr/share/elasticsearch/data2

docker run -d -p 9200:9200 -p 9300:9300 -v /esdata/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /data/elas_data:/usr/share/elasticsearch/data -v /esdata/es_data2:/usr/share/elasticsearch/data2 -v /data/elas_plugins:/usr/share/elasticsearch/plugins --name elas_master elasticsearch:5.3.2


