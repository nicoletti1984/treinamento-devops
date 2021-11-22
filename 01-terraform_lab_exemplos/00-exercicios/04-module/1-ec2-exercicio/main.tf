provider "aws" {
  region = "sa-east-1"
}

module "criar_instancia" {
  source = "git@github.com:nicoletti1984/aulaGitGama2.git"
  nome = "ec2-turma2-diego-module"
}
