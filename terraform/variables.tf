variable "project" {
  default = "V-project"
}
variable "ENV" {
  default = "Dev"
}
variable "ami_id" {
  default = "ami-0b6c6ebed2801a5cb"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "servers" {
  type    = list(string)
  default = ["jenkins", "docker", "nexus"]
}