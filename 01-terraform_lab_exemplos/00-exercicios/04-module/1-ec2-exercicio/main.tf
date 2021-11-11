provider "aws" {
  region = "sa-east-1"
}

module "criar_instancia" {
  source = "./instancia"
  nome = "ec2-turma2-diego-module"
}
