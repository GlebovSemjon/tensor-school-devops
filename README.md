cd 1.hometasks
ansible-playbook -i inventory.yaml main.yaml
=============================================
cd 2.hometasks
ansible-playbook -i inventory.yaml add_users.yaml --ask-vault-pass
vault-pass: Pass

