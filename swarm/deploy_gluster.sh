#!/bin/bash
# Declarar un array asociativo
declare -A NODE_IPS=(
  [swarm-mgr]="192.168.56.10"
  [swarm-node1]="192.168.56.11"
  [swarm-node2]="192.168.56.12"
)

MANAGER=swarm-mgr

# Instalar GlusterFS en todos los nodos
for NODE in "${!NODE_IPS[@]}"; do
  vagrant ssh $NODE -c "sudo apt update && sudo apt install -y glusterfs-server && sudo mkdir -p /gluster/brick1 /mnt/glusterfs"
  vagrant ssh $NODE -c "sudo systemctl start glusterd && sudo systemctl enable glusterd"
done

# Conectar peers
vagrant ssh $MANAGER -c "sudo gluster peer probe ${NODE_IPS[swarm-node1]}"
vagrant ssh $MANAGER -c "sudo gluster peer probe ${NODE_IPS[swarm-node2]}"

# Crear volumen
vagrant ssh $MANAGER -c "sudo gluster volume create gv0 replica 3 \
  ${NODE_IPS[swarm-mgr]}:/gluster/brick1 \
  ${NODE_IPS[swarm-node1]}:/gluster/brick1 \
  ${NODE_IPS[swarm-node2]}:/gluster/brick1 force && sudo gluster volume start gv0"

# Montar en cada nodo
for NODE in "${!NODE_IPS[@]}"; do
  vagrant ssh $NODE -c "sudo mount -t glusterfs $NODE:/gv0 /mnt/glusterfs"
done
