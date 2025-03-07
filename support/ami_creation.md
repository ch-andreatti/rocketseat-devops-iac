This document will provide the instructions to create the AMI utilized at Terraform script

# 1. Create an EC2 instance at AWS

Instruction about how to create an instance: [link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)

# 2. Install apache

Inside the instance, execute the following commands:

## Amazon Linux / RHEL

```
sudo yum update -y
sudo yum install -y httpd

sudo systemctl start httpd
sudo systemctl enable httpd

sudo systemctl status httpd # Verify if apache is running
```

## Ubuntu / Debian

```
sudo apt update -y
sudo apt install -y apache2

sudo systemctl start apache2
sudo systemctl enable apache2

sudo systemctl status apache2 # Verify if apache is running
```

You can also access your instance to verify if apache is running: `http://your-ec2-public-ip`

**Note:** To access your instance, it must be on a subnet with Internet access. You can create this infrastructure executing only the `Networking` part of `src/main.tf` Terraform script

# 3. Create AMI from your instance

Access the **AWS Console** and go to **EC2**.  

In the left menu, click on **Instances**.  

Select the instance you want to convert into an AMI.  

In the upper right corner, click on **Actions** → **Image and templates** → **Create Image**.  

Fill in the details:   
   - **Image name**: Name for the AMI   
   - **Image description**: Description (optional)  
   - **No reboot**: If enabled, the instance will not reboot (not recommended for production systems)  
   - **Storage settings**: Configure the volumes (you can increase the disk size)  

Click on **Create Image**.  

The AMI will now be created and will be available under **Images > AMIs**.

# 4. Collect the AMI ID

At **AMIs** page collect the **AMI ID** and store it at `terraform.tfvars` file in the following format: `ami_id = "<AMI id>"`
