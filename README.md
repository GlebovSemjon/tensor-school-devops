ДЗ 1
==
cd 1.hometasks
ansible-playbook -i inventory.yaml main.yaml

ДЗ 2
==
Задача 1:
--
cd 2.hometasks  
ansible-playbook -i inventory.yaml add_users.yaml --ask-vault-pass  
vault-pass: Pass  

Задача2:
--
ansible-playbook -i inventory.yaml HW/db_init/main.yaml  
