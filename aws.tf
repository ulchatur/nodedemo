resource "aws_instance" "test-_instance"{

ami="ami-0de53d8956e8dcf80"
instance_type="t2.medium"
associate_public_ip_address = "true"
subnet_id = "subnet-16dfeb28"
vpc_security_group_ids = ["sg-0d4862aebf59f17f2"]
key_name = "ansible"

root_block_device   {
volume_type = "gp2"
volume_size = "50"
encrypted   = true
}
user_data = <<HEREDOC
  #!/bin/bash
  sudo yum update -y
  sudo yum install docker -y
  sudo yum install git -y
  sudo yum install wget -y
  sudo service docker start
  sudo wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  sudo rpm -ivh epel-release-latest-7.noarch.rpm
  sudo yum --enablerepo=epel install ansible -y
HEREDOC
}
