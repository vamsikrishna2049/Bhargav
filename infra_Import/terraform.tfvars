# Map of EC2 instance configurations to be created or imported.
# Note: if you don't mention the correct details, it will create the resource. 
# Else it will import the resources and store in terraform.statefile
# Each key (e.g., "test1") represents a logical instance name, and the
# associated values define all required attributes for provisioning or
# importing that specific EC2 instance.

instance_ids = {
  test1 = {
    ami             = "ami-0ecb62995f68bb549"    # AMI to use for this EC2 instance
    instance_type   = "t2.micro"                 # EC2 instance size
    subnet_id       = "subnet-0d1e21c92d85a9bd8" # Subnet where the instance will be deployed
    security_groups = ["sg-0ab5f0de13b563637"]   # Security groups attached to the instance

    tags = {
      Name       = "Test-Pub-Machine-1" # Tags applied to the instance
      CostCenter = "ATM"
      ManagedBy  = "Terraform"
    }
  }

  # ---------------------------------------------------------------------------
  # To manage or import multiple EC2 instances, simply uncomment and duplicate
  # the structure below. Ensure that each key (e.g., "test2") is unique.
  #
  # Example:
  #
  # test2 = {
  #   ami             = "ami-0ecb62995f68bb549"          # AMI used for second instance
  #   instance_type   = "t3.micro"                       # EC2 instance size
  #   subnet_id       = "subnet-05e4817853cad9a09"       # Subnet placement
  #   security_groups = ["sg-05b16edf10d686977"]         # Security groups assigned
  #
  #   tags = {
  #     Name = "ubuntu-2"                                # Optional tag block
  #   }
  # }
  # ---------------------------------------------------------------------------
}
