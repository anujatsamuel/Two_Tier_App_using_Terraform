# Two_Tier_App_using_Terraform

![image](https://github.com/anujatsamuel/Two_Tier_App_using_Terraform/assets/138687534/bb534a1c-d046-49c0-bb14-32dbd5af0afb)

Implement 2 tier architecture using Terraform which should be highly available and scalable. so to achieve that we gonna use the following list of services of AWS. you can use any cloud provider that you like. in my case it is AWS.

📃 list of services

Amazon Certificate Manager (SSL)

Amazon Route 53 (DNS service)

Amazon CloudFront(CND)

Amazon EC2 (Server)

Amazon Auto Scaling group (Scale on demand)

Amazon VPC (Virtual private cloud: Private Network)

Amazon RDS (Relational database services: Database)

Amazon DynamoDB (State-locking for tfstate file)

Amazon S3 (storing backend and achieving versioning)

Amazon CloudWatch (Alarm when CPU utilization increase or decreases)

so let's get started.


🏠Two-tire architecture
Two-tier architecture, also known as client-server architecture, is a software design pattern that divides an application into two main parts or tiers: the client tier and the server tier. Each tier has specific responsibilities and interacts with each other to provide functionality to end-users.

1. Install Terraform
2. Create an S3 bucket to store the .tfstate file in the remote backend

Warning! It is highly recommended that you enable Bucket Versioning on the S3 bucket to allow for state recovery in the case of accidental deletions and human error.

Note: We will need this bucket name in the later step

3. Create a Dynamo DB table for state file locking

Give the table a name
Make sure to add a Partition key with the name LockID and type as String
4. Generate a public-private key pair for our instances

We need a public key and a private key for our server so please follow the procedure I've included below.

cd modules/key/
ssh-keygen
The above command asks for the key name and then gives client_key it will create pair of keys one public and one private. you can give any name you want but then you need to edit the Terraform file

Edit the below file according to your configuration

vim root/backend.tf

Add the below code in root/backend.tf

terraform {
  backend "s3" {
    bucket = "BUCKET_NAME"
    key    = "backend/FILE_NAME_TO_STORE_STATE.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamoDB_TABLE_NAME"
  }
}
5. 🏠 Let's set up the variable for our Infrastructure

Create one file with the name of terraform.tfvars

vim root/terraform.tfvars

6. 🔐 ACM certificate

Go to AWS console --> AWS Certificate Manager (ACM) and make sure you have a valid certificate in Issued status, if not , feel free to create one and use the domain name on which you are planning to host your application.

7. 👨‍💻 Route 53 Hosted Zone
Go to AWS Console --> Route53 --> Hosted Zones and ensure you have a public hosted zone available, if not create one.

8. Add the below content into the root/terraform.tfvars file and add the values of each variable.

region = ""
project_name = ""
vpc_cidr                = ""
pub_sub_1a_cidr        = ""
pub_sub_2b_cidr        = ""
pri_sub_3a_cidr        = ""
pri_sub_4b_cidr        = ""
pri_sub_5a_cidr        = ""
pri_sub_6b_cidr        = ""
db_username = ""
db_password = ""
certificate_domain_name = ""
additional_domain_name = ""

✈️ Now we are ready to deploy our application on the cloud ⛅

9. Get into the project directory

cd root

10. 👉 let install dependency to deploy the application

terraform init 

11. Type the below command to see the plan of the execution

terraform plan

12. ✨Finally, HIT the below command to deploy the application...

terraform apply 

Type yes, and it will prompt you for approval..
