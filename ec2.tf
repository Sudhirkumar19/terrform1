resource "aws_security_group" "allow_ssh_terraform" {
    name = "allow_sshh"
    description = "allow port number 22 for ssh access"

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]

    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]  # allow everyone to access
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow_ssh_terraform"
    }

}

resource "aws_instance" "terraform" {
    ami           = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]

    tags = {
    Name = "terraform-ec2-instance"
    }
}

# understanding and self notes:
#=================================

# ingress : incoming traffic
# egress : outgoing traffic
# terrform init = to initialize the terraform configuration
# keep .gitignore file to ignore terraform.tfstate file to avoid high data into aws s3 bucket
# terrform plan = can't create the resource, only show what resource will be created
# terrform apply = to create the resource in aws
#vpc_security_group_ids  = here we are giving the security group id which is alread created by us in resource "aws_security_group" "allow_ssh_terraform"
#from it we are taking the id using aws_security_group.allow_ssh_terraform.id

