resource "aws_instance" "name" {
  ami = "i-jkfdashfkjasdhf"
  instance_type = "t2.micro"
  key_name = "Mahi"

  tags = {
    Name = "Server1" #Adding this tag to get more clearness
  }
}
