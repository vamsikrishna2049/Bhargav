instance_ids = {
  test1 = {
    ami             = "ami-0ecb62995f68bb549"
    instance_type   = "t2.micro"
    subnet_id       = "subnet-010cad9594c26bfac"
    security_groups = ["sg-05b16edf10d686977"]
    tags = {
      Name = "ubuntu"
    }
  }
  test2 = {
    ami             = "ami-0ecb62995f68bb549"
    instance_type   = "t3.micro"
    subnet_id       = "subnet-05e4817853cad9a09"
    security_groups = ["sg-05b16edf10d686977"]
  }
}
