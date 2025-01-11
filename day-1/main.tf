resource "aws_instance" "name" {
  ami = "i-jkfdashfkjasdhf"
  instance_type = "t2.micro"
  key_name = "Mahi"
  subnet_id = ""

  tags = {
    Name = "Server1" #Adding this tag to get more clearness
  }
}
