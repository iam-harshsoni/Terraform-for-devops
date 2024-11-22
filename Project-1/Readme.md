# Setting up Infrastructure Using Terraform on AWS

This project demonstrates the process of creating and managing AWS infrastructure using **Terraform**, an Infrastructure as Code (IaC) tool. The setup includes a VPC, public subnets, EC2 instances with custom user data scripts, and an S3 bucket for storage.

## Architecture Diagram

![image](https://github.com/user-attachments/assets/773e71dc-7ae1-4c59-836c-5a3574a94377)

The diagram illustrates the infrastructure setup, including the following components:
- **AWS VPC** for networking.
- **Public Subnets** hosting two EC2 instances.
- **S3 Bucket** for centralized storage.
- **Internet Gateway** for internet connectivity to make subnet public
- **Load Balancer** to balance load on EC2 Instances
- **IAM Role** To access s3 bucket from EC2 Instances.

## Features

- **VPC Creation**: Sets up a Virtual Private Cloud (VPC) to host the infrastructure.
- **Public Subnets**: Configures public subnets for EC2 instances.
- **EC2 Instances**: Provisions two EC2 instances in the public subnets.
- **User Data Scripts**: Deploys custom startup scripts (`userdata.sh` and `userdata2.sh`) to configure EC2 instances during launch.
- **S3 Bucket**: Creates an S3 bucket for data storage.
- **Automation**: Leverages Terraform to automate the entire setup.

## Files Included

1. **main.tf**: Contains the main Terraform configuration for defining resources such as VPC, subnets, EC2 instances, and S3 bucket.
2. **provider.tf**: Specifies the AWS provider configuration, including region and credentials.
3. **variables.tf**: Defines input variables to parameterize the Terraform configuration.
4. **userdata.sh**: Custom script to configure the first EC2 instance during launch.
5. **userdata2.sh**: Custom script to configure the second EC2 instance during launch.
6. **images/**: Folder containing images to be uploaded in s3 bucket.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) installed on your local machine.
- AWS CLI configured with appropriate credentials.
- Basic understanding of AWS and Terraform.

## Steps to Use

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Preview Changes**:
   ```bash
   terraform plan
   ```

4. **Apply Changes**:
   ```bash
   terraform apply
   ```

5. **Destroy Infrastructure (Optional)**:
   To remove the resources created by Terraform, run:
   ```bash
   terraform destroy
   ```
   
## Blog Link

For a detailed explanation of this project, including screenshots of the setup and execution, visit my blog:  
[**Setting up Infrastructure Using Terraform on AWS**](<insert-your-blog-link-here>)

## Customization

- Modify the **variables.tf** file to customize resource configurations, such as instance type, region, and S3 bucket name.
- Update the **userdata.sh** and **userdata2.sh** scripts to include custom startup commands for your EC2 instances.

## Acknowledgments

Special thanks to:
**Abhishek Veeramala** and **Cloud Champ** for their guidance and support throughout the learning journey.
