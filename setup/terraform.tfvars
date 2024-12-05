ami = "ami-0453ec754f44f9a4a"
instance_type = "t2.micro"
vpc_cidr = "172.16.0.0/16"
public_subnet_cidr = [
    "172.16.0.0/20", 
    "172.16.16.0/20"
]

private_subnet_cidr = [
    "172.16.32.0/20",
    "172.16.48.0/20" ,
    "172.16.64.0/20",
    "172.16.80.0/20"
]
