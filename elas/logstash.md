### logstash redis配置文件
```
input {
  redis {
      data_type => 'channel'
      key => 'tcp_receive'
      host => '115.29.9.156'
      # host => '10.122.73.1'
      password => '...'
  }
}

filter {
  alter {
    add_field => {
      # "time" => %{@timestamp}
      "dir" => -1
    }
    remove_field => ["src_seq", "encrypted", "@version", "w_encrypted", "user_key_index", "version", "src_cost"]
  }
  mutate {
    convert => {
      "dir" => "integer"
    }
  }
}

output {
  elasticsearch {
    hosts => ["172.28.128.7:9200"]
    index => "logs_%{+YYYY-MM-dd}"
    document_type => "logs"
    flush_size => 20000
    idle_flush_time => 10
  }
  # stdout {
  #   codec => plain {
  #     format => "{time:%{@timestamp},device_addr:%{device_addr},teleport_addr:%{teleport_addr},op:%{op},params:%{params}}"
  #   }
  # }
  # stdout {
  #   codec => rubydebug
  # }
}
# nohup command &> /dev/null &
# 自动加载配置文件
# logstash –f apache.config --config.reload.automatic
# logstash -f config_file --auto-reload --reload-interval 2 
```