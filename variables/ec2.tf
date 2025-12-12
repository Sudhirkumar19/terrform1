resource "aws_security_group" "allow_ssh_terraform" {
    name = var.sg_name
    description = var.sg_description

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]

    }

    ingress {
        from_port       = var.from_port
        to_port         = var.to_port
        protocol        = var.protocol
        cidr_blocks     = var.ingress_cidr  # allow everyone to access
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = var.tags

}

resource "aws_instance" "terraform" {
    ami           = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]

    tags = {
    Name = "terraform-ec2-instance"
    }
}

# understanding and self notes:
#=================================
# first do the AWS configure before using terraform in git and mention access key and secret key, do not share in code as it is secret
# ingress : incoming traffic
# egress : outgoing traffic
# terrform init = to initialize the terraform configuration
# keep .gitignore file to ignore terraform.tfstate file to avoid high data into aws s3 bucket
# terrform plan = can't create the resource, only show what resource will be created
# terrform apply = to create the resource in aws
#vpc_security_group_ids  = here we are giving the security group id which is alread created by us in resource "aws_security_group" "allow_ssh_terraform"
#from it we are taking the id using aws_security_group.allow_ssh_terraform.id

