output "instance-pub-ip" {
  value = aws_instance.web_server.public_ip
}