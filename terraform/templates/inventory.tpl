[workers]
%{ for name, ip in workers ~}
${name} ansible_host=${ip}
%{ endfor ~}

[workers:vars]
ansible_user=azureuser
ansible_ssh_private_key_file=/home/azureuser/.ssh/terraform_lab
ansible_python_interpreter=/usr/bin/python3