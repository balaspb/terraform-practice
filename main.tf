
provider "aws" {
  region = "ap-south-1"

}


resource "aws_key_pair" "examplekp" {
  key_name   = "example-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzoxV1nhSCEAs7A+d/DeS6zPDsHrI/IbHNVPiEmIoYSWC0qZtk4XRYGceaWfpS07u2lsUUCjR4Yiu8bdL8iyFDuT/2w8P0GN3AOrylvtBeQtE/U38of3NSTfjJMRkmdvZ+JnKWdM+WXS13GBTa9qVqb8WeVIuE9AgG1ZWNuGJCFnyTi13f774VfZN0V5eKOLCRMY13h7rr9CZHMEX5dCyHjutyA7/JqKOyGWN/dp3PlcLosFTtIqP0ZnLIkdswMaZ77r3/wUlTkknBYJ7dTa/WvxdCVNqq4nIZAsfoyiIiJAq+ORfrFeZ0vGK5OjDV0LA9Qn5/rQQTkqeKhvD9XexL"


}
resource "aws_security_group" "examplesg" {
  name        = "examplesg"
  description = "Allow TLS inbound traffic"


  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0ce933e2ae91880d3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "${aws_key_pair.examplekp.id}"
  tags = {
    Name = "my-webserver-instance"
  }
}