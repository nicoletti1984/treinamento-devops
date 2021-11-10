resource "local_file" "teste" {
  count = 10
  filename = "Aula-${count.index}.txt"
  content = "Olá alunos bem vindo ao terraform ${count.index}.0"
}