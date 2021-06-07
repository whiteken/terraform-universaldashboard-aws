# Terraform / AWS / Universal Dashboard / IIS

This repo is a home project containing HCL Terraform code to spin up a Windows Server 2019 EC2 t2.micro instance in AWS, running a basic IIS hosted Universal Dashboard (v.2.9.0) website and REST API.

[Universal Dashboard](https://docs.universaldashboard.io/) is a PowerShell Dashboarding product from [Ironman Software](https://ironmansoftware.com/) - no affiliation, just a fan! v2.9.0 is a legacy version. The latest version is PowerShell Universal which will be available in another similar IaC repo on this account soon.  Universal Dashboard is a paid product but the [community edition](https://www.powershellgallery.com/packages/UniversalDashboard.Community/2.9.0) is free.

### Pre-requisites:
- [Terraform](https://www.terraform.io/downloads.html) installed locally 
- A valid [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- The [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) installed locally
- A domain name hosted on AWS
- An EC2 Key Pair (search for "EC2 Key Pair" on the AWS console homepage)

*If you want to access the API or Dashboard website remotely via the DNS entries created by the Terraform code, a paid license for Universal Dashboard is needed, but it's not required to run the terraform or create the infra.*

Your AWS credentials should also be configured locally.  To do this, run ```aws configure```

Follow the prompts to input your AWS Access Key ID and Secret Access Key, which you'll find on [this page](https://console.aws.amazon.com/iam/home?#security_credential).

The configuration process creates a file at ```~/.aws/credentials``` on macOS and Linux or ```%UserProfile%\.aws\credentials``` on Windows, where your credentials are stored.

With all that in place you can now use the repo! :)

### To use this repo:

- Clone as normal
- Navigate to the IaC folder
- From that folder, run: ```terraform init ``` (which will download the required AWS provider)
- Next run: ```terraform plan```
- Followed by: ```terraform apply```

### After a succesful run the following infra is created in AWS:

- 1 x EC2 t2.micro instance
    Configured with 1 x 40GB HD, 2 x 10 GB HD
- 1 x VPC
- 1 x Subnet 
- 1 x Internet Gateway
- 2 x Security Groups
- 1 x DNS Zone
- 1 x Public IP (not static)
- 3 x DNS CNAMES 

The gateway is attached to the VPC and routing is configured for outbound Internet access.

### Terraform variables
.gitignore is properly configured to exclude the ```terraform.tfvars``` file.  Create a blank file with that name in the IaC directory and copy the text below.  Fill in the blank values with the appropriate values for your own infra.

```
admin_password           = ""
key_name                 = ""
aws_region               = ""
aws_availability_zone    = ""
myIP                     = ""
myPublicDomain           = ""
public_DNS_CNAMES        = ["www", "uddashboard", "udrestapi"]
gitHub_winRM_cert_script = "https://raw.githubusercontent.com/whiteken/terraform-universaldashboard-aws/master/userdata/ConfigureRemoting.ps1"
UD_version_number        = "2.9.0"
ec2_additional_disk_1    = "xvdf"
ec2_additional_disk_2    = "xvdg"
ec2_ami_name_searchstring = ""*windows-2019-Full*""
```

*Note1: I've had varying degrees of success with applying the EC2 Userdata.  The configuration steps themselves are sound, but occasionally they are simply not executed.  In the end I've created an AMI after a successful run, as in best practice, but recording the steps here for later reference.*


*Note2: Make sure you understand what you are deploying.  You can be charged by AWS for anything you create!*