output "server_ips" {
  value = {
    for idx, inst in aws_instance.server :
    var.servers[idx] => inst.public_ip
  }
}

# resource "local_file" "inventory" {
#   content = join("\n", [
#     "[ansible]",
#     lookup(aws_instance.server[0], "public_ip"),
#     "",
#     "[docker]",
#     lookup(aws_instance.server[1], "public_ip"),
#     "",
#     "[jenkins]",
#     lookup(aws_instance.server[2], "public_ip")
#     ])


#   filename = "C:/Users/HP/Desktop/DevOps/V-project/ansible"
# }
