resource "aws_instance" "myvm" {
  ami           = "" #(we need to add from statefile reference)
  instance_type = "" #(we need to add from statefile reference)
  tags = {
    Name = "my_ec2"
  }
}

#Command : terrform import aws_instance.myvm <instance id>
