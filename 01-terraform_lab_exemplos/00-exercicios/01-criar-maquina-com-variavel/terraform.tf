terraform {
  backend "remote" {
    organization = "diego-curso-gama2"

    workspaces {
      name = "workspace-diego"
    }
  }
}
