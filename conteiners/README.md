ДЗ #1  
==
Задача 1  
--
cd 1.homework  
docker build ./node1 -t node1  
docker build ./node2 -t node2  
docker run --name node_I --mount type=bind,src=$(pwd),dst=/var --blkio-weight 1000  node1  
docker run --name node_II --mount type=bind,src=$(pwd),dst=/var --blkio-weight 0  node2  

Задача 2  
--
