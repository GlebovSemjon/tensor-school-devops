ДЗ #1  
==
Задача 1  
--
docker build ./node1 -t node1  
docker build ./node2 -t node2  
docker run --name nodeI --mount type=bind,src=$(pwd),dst=/var --blkio-weight 1000  node1  
docker run --name nodeII --mount type=bind,src=$(pwd),dst=/var --blkio-weight 0  node2  
Задача 2  
--
