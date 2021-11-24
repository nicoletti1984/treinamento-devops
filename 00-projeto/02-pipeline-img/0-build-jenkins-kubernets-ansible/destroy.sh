#!/bin/bash

cd 00-projeto/02-pipeline-img/0-build-jenkins-kubernets-ansible/0-terraform
ID_MAQUINA=$(terraform output | grep id | awk '{print $2;exit}')
echo ${ID_MAQUINA/\",/}

# cd ../2-terraform-ami/
# TF_VAR_resource_id=xxx TF_VAR_versao=v0.1.1 terraform destroy -auto-approve

cd ../0-terraform
terraform destroy -auto-approve
