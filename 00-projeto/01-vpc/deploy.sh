#!/bin/bash

# ID_M1_DNS="ubuntu@ec2-18-234-97-123.compute-1.amazonaws.com"
# ID_M1_DNS=$(echo "$ID_M1_DNS" | cut -b 8-)
# echo ${ID_M1_DNS}

#### idéia para buscar itens do debugger do ansible ####
# | grep -oP "(kubeadm join.*?certificate-key.*?)'" | sed 's/\\//g' | sed "s/'//g" | sed "s/'t//g" | sed "s/,//g"

cd terraform
terraform init
terraform apply -auto-approve

echo  "Aguardando a criação das maquinas ..."
sleep 15

#ID_M1=$(terraform output | grep 'ec2-proj-diego-1 -' | awk '{print $4;exit}')
#ID_M1_DNS=$(terraform output | grep 'ec2-proj-diego-1 -' | awk '{print $9;exit}' | cut -b 8-)

ID_M1=$(terraform output | grep 'ec2-proj-diego-1 -' | awk '{print $3;exit}')
ID_M1_DNS=$(terraform output | grep 'ec2-proj-diego-1 -' | awk '{print $8;exit}' | cut -b 8-)

ID_M2=$(terraform output | grep 'ec2-proj-diego-2 -' | awk '{print $3;exit}')
ID_M2_DNS=$(terraform output | grep 'ec2-proj-diego-2 -' | awk '{print $8;exit}' | cut -b 8-)

ID_M3=$(terraform output | grep 'ec2-proj-diego-3 -' | awk '{print $3;exit}')
ID_M3_DNS=$(terraform output | grep 'ec2-proj-diego-3 -' | awk '{print $8;exit}' | cut -b 8-)

cd ..

echo "
[ec2-proj-diego-1]
$ID_M1_DNS
[ec2-proj-diego-2]
$ID_M2_DNS
[ec2-proj-diego-3]
$ID_M3_DNS
" > ansible/hosts/hosts

cd ansible

#ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa

ANSIBLE_HOST_KEY_CHECKING=False USER=root PASSWORD=root DATABASE=SpringWebYoutube ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa
