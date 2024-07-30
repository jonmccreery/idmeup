./gcp_tf_perms.sh

cd terraform
terraform apply

cd ../ansible
ansible-galaxy install -r requirements.yml

ansible-playbook --private-key ../../secret/ansible -u ansible -i idmeup.ini db.yml
ansible-playbook --private-key ../../secret/ansible -u ansible -i idmeup.ini app.yml
ansible-playbook --private-key ../../secret/ansible -u ansible -i idmeup.ini http.yml
ansible-playbook --private-key ../../secret/ansible -u ansible -i idmeup.ini monitor.yml
