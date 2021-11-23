#!/bin/bash

VERSAO=$(git describe --tags $(git rev-list --tags --max-count=1))

cd 00-projeto/02-pipeline-img/0-build-jenkins-kubernets-ansible/0-terraform
#RESOURCE_ID=$(/home/ubuntu/terraform output | grep resource_id | awk '{print $2;exit}' | sed -e "s/\",//g")
RESOURCE_ID=$(terraform output | grep resource_id | awk '{print $2;exit}' | sed -e "s/\",//g")


cd ../terraform-ami
#/home/ubuntu/terraform init
#TF_VAR_versao=$VERSAO TF_VAR_resource_id=$RESOURCE_ID /home/ubuntu/terraform apply -auto-approve

terraform init
TF_VAR_versao=$VERSAO TF_VAR_resource_id=$RESOURCE_ID terraform apply -auto-approve
