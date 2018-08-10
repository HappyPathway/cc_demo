# Rename this to `terraform.auto.tfvars` and edit.
# You should set all of the variables.
# In particular, 'project_name' and 'hashi_tags["owner"]' 
# combined set the Consul 'cluster name' which the cloud
# auto-join uses --- if you want to run more than one instance
# of this in a single AWS account, you'll need to make these
# distinct to keep the instances separate.

project_name    = "darnold-cc-demo"
hashi_tags      = { "TTL" = "48", owner = "darnold@hashicorp.com", "project" = "Darnold Consul Connect Demo" }

# Images currently only exist in "us-east-1"
aws_region      = "us-east-1"

# This is the name of an already existing SSH Keypair in AWS
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
ssh_key_name    = "tfe-demos-darnold"

# By default, we start in a "noconnect" mode --- this tells Terraform
# to deploy the version of this demo that has Consul but does not use
# Consul Connect. But when you switch to "connect" mode, this will
# cause Terraform to deploy the version which has Consul Connect enabled
mode             = "noconnect"
