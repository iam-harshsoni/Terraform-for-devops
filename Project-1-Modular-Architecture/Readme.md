# Setting up AWS Infrastructure Using Terraform (Modular Architecture)

This project demonstrates the implementation of a **modular architecture** to set up AWS infrastructure using **Terraform**. It includes the creation of a VPC, public subnets, EC2 instances, an S3 bucket, and advanced components like a Load Balancer, Target Group, and Listener. This modular approach ensures that the project is **organized**, **scalable**, and **reusable**.

---

## Architecture Diagram

Include the diagram image here, stored in your `images/` folder:  
![image](https://github.com/user-attachments/assets/3d85e5ba-d420-4ddb-b2ec-34c004855ee4)

---
## Features

- **VPC Module**: Creates the base network architecture.
- **Subnet Module**: Provisions subnets within the VPC.
- **Internet Gateway Module**: Adds internet connectivity to the VPC.
- **Route Table Module**: Configures routing for public subnets.
- **Security Group Module**: Creates security groups to control instance traffic.
- **IAM Roles Module**: Manages IAM roles for EC2 instances.
- **EC2 Module**: Provisions EC2 instances with user data.
- **S3 Module**: Sets up an S3 bucket and its objects for storage.
- **Load Balancer Module**: Deploys an Application Load Balancer.
- **Target Group and Listener Modules**: Configures target groups and listeners for the Load Balancer.
- **User Data Scripts**: Automates EC2 instance configuration during startup.

---

## Directory Structure

The project is organized as follows:

```plaintext
├── main.tf                          # Root module to orchestrate all submodules
├── modules/                         # Folder containing reusable modules
│   ├── 1.vpc/                       # VPC module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 2.subnets/                   # Subnets module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 3.igw/                       # Internet Gateway module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 4.route_table/               # Route Table module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 5.security_group/            # Security Group module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 6.iam_roles/                 # IAM Roles module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 7.ec2_instances/             # EC2 Instances module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── userdata.sh              # User data script for instance 1
│   │   ├── userdata2.sh             # User data script for instance 2
│   │   └── variables.tf
│   ├── 8.s3_bucket/                 # S3 Bucket module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 9.s3_bucket_object/          # S3 Bucket Object module
│   │   ├── images/                  # Images folder for documentation
│   │   │   ├── terraform-1.png
│   │   │   └── terraform-2.png
│   │   ├── local.tf
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 10.loadbalancer/             # Load Balancer module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── 11.target_group/             # Target Group module
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   └── 12.loadbalancer_listener/    # Load Balancer Listener module
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
├── provider.tf                      # AWS provider configuration
├── variables.tf                     # Global variables
├── terraform.tfstate                # Terraform state file
├── terraform.tfstate.backup         # Backup of Terraform state file
```

---

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

5. **Destroy Infrastructure**:
   To tear down the resources, run:
   ```bash
   terraform destroy
   ```

---

## Blog Link

For a detailed explanation of this project, including step-by-step implementation and screenshots, refer to the blog:  
[**AWS Infrastructure Setup with Terraform (Modular Architecture)**](<https://harshdevopss.hashnode.dev/step-by-step-guide-to-creating-aws-cloud-infrastructure-with-terraform>)

---

## Key Advantages of Modular Architecture

- **Reusability**: Each module is reusable across different projects.
- **Scalability**: Easily scale the infrastructure by adding new modules or extending existing ones.
- **Maintainability**: Separation of concerns makes the code easier to manage.
- **Collaboration**: Allows teams to work on different modules simultaneously.

---

## Acknowledgments

- Special thanks to **HashiCorp** for Terraform and **AWS** for their powerful cloud services.  
- Gratitude to **Abhishek Veeramala** and **Cloud Champ** for their guidance and encouragement.
