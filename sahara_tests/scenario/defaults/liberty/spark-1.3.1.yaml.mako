<%page args="is_proxy_gateway='true', use_auto_security_group='true'"/>

clusters:
  - plugin_name: spark
    plugin_version: 1.3.1
    image: ${spark_1_3_image}
    node_group_templates:
      - name: master
        flavor: ${ci_flavor_id}
        node_processes:
          - master
          - namenode
        auto_security_group: ${use_auto_security_group}
        is_proxy_gateway: ${is_proxy_gateway}
      - name: worker
        flavor: ${ci_flavor_id}
        node_processes:
          - datanode
          - slave
        auto_security_group: ${use_auto_security_group}
    cluster_template:
      name: spark131
      node_group_templates:
        master: 1
        worker: 1
      cluster_configs:
        HDFS:
          dfs.replication: 1
    cluster:
      name: ${cluster_name}
    scaling:
      - operation: add
        node_group: worker
        size: 1
    edp_jobs_flow:
      - spark_pi
      - spark_wordcount
