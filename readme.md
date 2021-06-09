# Terraform / AWS / Universal Dashboard / IIS

###### This repo is a home project containing HCL Terraform code to spin up a Windows Server 2019 EC2 t2.micro instance in AWS, running a basic IIS hosted Universal Dashboard (v.2.9.0) website and REST API.

___

[Universal Dashboard](https://docs.universaldashboard.io/) is a PowerShell Dashboarding product from [Ironman Software](https://ironmansoftware.com/) - no affiliation, just a fan! v2.9.0 is a legacy version. In the latest version PowerShell Universal Dashboard is now part of [PowerShell Universal](https://ironmansoftware.com/powershell-universal). 


*If you want to access the API or Dashboard website **remotely** via the DNS entries created by the Terraform code, a paid license for Universal Dashboard Enterprise is needed, but it's not required to run the terraform or create the infra. Alternatively update the code to use the free [community edition](https://www.powershellgallery.com/packages/UniversalDashboard.Community/2.9.0).*

___

### Pre-requisites:
- [Terraform](https://www.terraform.io/downloads.html) installed locally 
- A valid [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- [AWS provider authentication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) configured (see methods below).
- A registered domain on AWS. For this you can use [Route53](https://console.aws.amazon.com/route53/home#DomainListing:).
- An EC2 Key Pair (search for "EC2 Key Pair" on the AWS console homepage)
___

### AWS Provider Configuration
Terraform has several methods for AWS provider configuration:  

**Method 1 - Shared Credentials file**

Use the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html). 
With this installed, run ```aws configure```

Follow the prompts to input your AWS Access Key ID and Secret Access Key, which you'll find on [this page](https://console.aws.amazon.com/iam/home?#security_credential).

The configuration process creates a file at ```~/.aws/credentials``` on macOS and Linux or ```%UserProfile%\.aws\credentials``` on Windows, where your credentials are stored.

**Method 2 - Static Credentials**

Alternatively, static credentials can be provided by adding an access_key and secret_key in-line in the AWS provider block.  **Be careful not to commit this to a public repo!**

```
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
```

**Method 3 - Environment variables**

You can provide your credentials via the ```AWS_ACCESS_KEY_ID``` and ```AWS_SECRET_ACCESS_KEY```, environment variables, representing your AWS Access Key and AWS Secret Key, respectively.

___


### Terraform variables
.gitignore is properly configured to exclude the ```terraform.tfvars``` file which is required for correct operation of this repo.  To create your own, make a blank file with that name in the IaC directory and copy the text below.  Fill in the dummy values with the appropriate values for your own infra.

In the table below, myIP refers to the IP *as seen by AWS*, so use the outside IP of your Internet router. This can be retrieved with the following PowerShell:

```Invoke-RestMethod -uri 'http://ifconfig.me/ip' ```

**Terraform.tfvars file:**

```
admin_password           = "choose the admin password for your EC2 instance"
key_name                 = "the keyname for the EC2 Key Pair"
aws_region               = "choose an AWS region"
aws_availability_zone    = "choose an availability zone in the AWS region"
myIP                     = "your IP address (use CIDR: X.X.X.X/32)"
myPublicDomain           = "enteryourdomainhere.com"
public_DNS_CNAMES        = ["www", "uddashboard", "udrestapi"]
gitHub_winRM_cert_script = "https://raw.githubusercontent.com/whiteken/terraform-universaldashboard-aws/master/userdata/ConfigureRemoting.ps1"
UD_version_number        = "2.9.0"
ec2_additional_disk_1    = "xvdf"
ec2_additional_disk_2    = "xvdg"
ec2_ami_name_searchstring = ""*windows-2019-Full*""
```
___

With all that in place you can now use the repo! :)

___

### To use this repo:

- Clone as normal
- Navigate to the ```IaC``` folder
- Ensure ```terraform.fvars``` file is present and populated with your own correct values
- Ensure AWS provider is configured
- From the ```IaC``` folder, run: ```terraform init ``` (which will download the required AWS provider)
- Next run: ```terraform plan```
- Followed by: ```terraform apply```

___

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

___

Following a succesful run of the ec2 user data, the Universal Dashboard will be available on the CNAME created in your domain:
(yourdomain is a placeholder for the domain entered in the ```terraform.tfvars``` file)

http://uddashboard.yourdomain.com

The UD restapi is available on:

http://udrestapi.yourdomain.com

You can test the API with the following:

```Invoke-RestMethod http://udrestapi.yourdomain.com/api/user```

which should return:

```
Adam
Sarah
Bill
```

___

**Note1** - *I've had varying degrees of success with applying the EC2 PowerShell Userdata within the ec2.tf file.  The configuration steps themselves are sound, but occasionally they are simply not executed.  In the end I've created an AMI after a successful run, as in best practice, but recording the steps here for later reference.*

___

**Note2** - *Make sure you understand what you are deploying.  You can be charged by AWS for anything you create!*

___