## Neo4J dependency: dockerfile/java
## get java from trusted build
from dockerfile/java
maintainer Tiago Pires, tiago-a-pires@ptinovacao.pt

## install neo4j according to http://www.neo4j.org/download/linux
run wget -O neo4j.tar.gz 'http://neo4j.com/artifact.php?name=neo4j-community-1.9.9-unix.tar.gz' && \
    tar xvfz neo4j.tar.gz && \
    mv neo4j-community-1.9.9 /var/lib/neo4j

## add launcher and set execute property
## turn on indexing: http://chrislarson.me/blog/install-neo4j-graph-database-ubuntu
## enable neo4j indexing, and set indexable keys to name,age
add launch.sh /
run chmod +x /launch.sh && \
    apt-get clean && \
    sed -i "s|#node_auto_indexing|node_auto_indexing|g" /var/lib/neo4j/conf/neo4j.properties && \
    sed -i "s|#node_keys_indexable|node_keys_indexable|g" /var/lib/neo4j/conf/neo4j.properties && \
    echo "remote_shell_host=0.0.0.0" >> /var/lib/neo4j/conf/neo4j.properties

# expose REST and shell server ports
expose 7474
expose 1337

workdir /

## entrypoint
cmd ["/bin/bash", "-c", "/launch.sh"]