1. Authenticate the Terraform with aws cloud via provider block.
2. Enter the existing resource details inside the terraform.tfvars file.
3. Import the resources the Terraform code
 terraform import 'aws_instance.imported["test1"]' i-03f20e1ea866fcdfd
4. Once the resources, started managing by terraform add tags to the ec2 instances. It will append to the existing.
      # New tags you want to add
      CostCenter  = "ATM"
      ManagedBy   = "Terraform"

      Ex:
      After modification, resource block will look like below

        test1 = {
    ami             = "ami-0ecb62995f68bb549"    # AMI to use for this EC2 instance
    instance_type   = "t2.micro"                 # EC2 instance size
    subnet_id       = "subnet-0d1e21c92d85a9bd8" # Subnet where the instance will be deployed
    security_groups = ["sg-05b16edf10d686977"]   # Security groups attached to the instance

    tags = {
      Name = "Test-Pub-Machine-1" # Tags applied to the instance
       # New tags you want to add
      CostCenter  = "ATM"
      ManagedBy   = "Terraform"
    }
  }
5. Apply Tag Changes
terraform plan
If you can able to see the plan correctly, apply it (terraform apply)
Terraform updates ONLY the tags —
EC2 instance will NOT be recreated.
