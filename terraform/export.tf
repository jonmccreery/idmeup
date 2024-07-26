resource "local_file" "ansible_ini_file" {
  content  = <<-EOF
  [nodes]
app
http
db
monitor

[apps]
app

[https]
http

[dbs]
db

[monitors]
monitor

[nodes:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -p 22 -W %h:%p -q -i ../../secret/ansible ansible@${google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip}"'
#ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -p 22 -W %h:%p -q -i ../../secret/ansible ansible@104.154.171.91"'
EOF
  filename = "../ansible/idmeup.ini"

}
