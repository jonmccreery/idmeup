cd terraform
terraform apply
cd ../ansible
ansible-playbook --private-key ../../secret/ansible -u ansible -i idme.ini http.yml
ansible-playbook --private-key ../../secret/ansible -u ansible -i idme.ini app.yml
ansible-playbook --private-key ../../secret/ansible -u ansible -i idme.ini monitor.yml
ansible-playbook --private-key ../../secret/ansible -u ansible -i idme.ini db.yml


