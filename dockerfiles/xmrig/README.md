# xmrig-miner

Mine monero with `xmrig` over a SOCKS5 tor proxy at http://moneroocean.stream

## Usage

1. edit `docker-compose.py` to add your wallet address
2. `sudo docker-compose up -d`

----

## To use with swarm mode

### 1. Setup the swarm

on the manager mode: `sudo docker swarm init`

on the worker nodes, copy-paste the line spit out from the manager node

### 2. Setup the image to your private registry

This is a bit of a process but here is the gist of it:

#### 3. On what will be your registry, probably some file server you have somewhere:

`sudo docker container run -d -p 5000:5000 --name registry -v /path/to/registry:/var/lib/registry registry`

This will run the registry container that will keep track of the tags pushed to it.

#### 4. Allow insecure traffic to the registry from the nodes

You need this as since this is local lan you probably don't have ssl certs passed around.

For every node in the cluster, add this file:

```
# $ /etc/docker/daemon.json
{ "insecure-registries": ["REGISTRY_IP:5000"] }
```

Now restart the docker daemon on all of the nodes.

#### 5. Create the image, tag it, and push to the registry

Now from a manager node:

```
sudo docker-compose build
sudo docker tag IMAGE_NAME REGISTRY_IP:5000/TAG_NAME
sudo docker push REGISTRY_IP:5000/TAG_NAME
```

### 6. OKAY, now that we have a local lan docker registry...

Let's push it to the swarm.

On the the manager node,

```
sudo docker stack deploy STACK_NAME -c docker-compose.yml
sudo docker service scale STACK_NAME_tor=NUMBER_OF_NODES
sudo docker service scale STACK_NAME_miner=NUMBER_OF_NODES
```

And that's it!

#### 7. (Optional) Visualize your running mining farm

On the manager node:

```
docker service create \
-p 8080:8080 \
--constraint=node.role==manager \
--mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
dockersamples/visualizer
```

Now, view in browser `http://$IP:8080`

*Visualizing with netapp / grafana coming sometime eventually maybe never*
