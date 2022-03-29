ДЗ #1  
==
Задача 1  
--
cd 1.homework  
docker build ./node1 -t node1  
docker build ./node2 -t node2  
docker run --name node_I --mount type=bind,src=$(pwd),dst=/var node1  
docker run --name node_II --mount type=bind,src=$(pwd),dst=/var node2  

Задача 2  
--
docker build ./node3 -t node3  
docker run --name node_III --mount type=bind,src=$(pwd),dst=/var -p 8080:8000 node3  

Задача 3  
--
echo "253:0 500000" > /sys/fs/cgroup/blkio/docker/7a61912bb07af045be9c36ef7a4ba7aa1c31f63ba1922ac3c36d4c1c35b0778f/blkio.throttle.write_bps_device  
