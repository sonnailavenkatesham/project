resource "aws_instance" "server" {
  count           = length(var.servers)
  ami             = var.ami_id

  instance_type = (
    var.servers[count.index] == "kubernetes" || var.servers[count.index] == "docker"
  ) ? "t2.medium" : var.instance_type

  security_groups = [aws_security_group.all_TCP.name]
  key_name        = "terrafrom"

  user_data = var.servers[count.index] == "jenkins" ? file("jenkins.sh") : var.servers[count.index] == "docker"  ? file("install_docker.sh") : file("kubeadm.sh")

  tags = {
    Name = "${var.project}-${var.ENV}-${var.servers[count.index]}"
  }
}


resource "local_file" "inventory" {
  content = join("\n", flatten([
    for idx, inst in aws_instance.server : [
      "[${var.servers[idx]}]",
      inst.public_ip,
      ""
    ]
  ]))

  filename = "C:/Users/HP/Desktop/DevOps/V-project/ansible/inventory.ini"
}