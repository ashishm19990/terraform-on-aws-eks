# HashiCorp Certified: Terraform Associate - 50 Practical Demos
[![Image](https://stacksimplify.com/course-images/hashicorp-certified-terraform-associate-highest-rated.png "HashiCorp Certified: Terraform Associate - 50 Practical Demos")](https://links.stacksimplify.com/hashicorp-certified-terraform-associate)

## Course Modules
01. Infrastructure as Code (IaC)
02. Install Tools on MacOs, LinuxOS and WindowsOS
03. Command Basics
04. Language Syntax
05. Settings Block
06. Providers Block
07. Multiple Providers usage
08. Dependency Lock File Importance
09. Resources Syntax and Behavior
10. Resources Meta-Argument - depends_on
11. Resources Meta-Argument - count
12. Resources Meta-Argument - for_each
13. Resources Meta-Argument - lifecycle
14. Input Variables - Basics
15. Input Variables - Assign When Prompted
16. Input Variables - Override default with cli var
17. Input Variables - Override with environment variables
18. Input Variables - Assign with terraform.tfvars
19. Input Variables - Assign with tfvars var-file argument
20. Input Variables - Assign with auto tfvars
21. Input Variables - Lists
22. Input Variables - Maps
23. Input Variables - Validation Rules
24. Input Variables - Sensitive Input Variables
25. File Function
26. Output Values
27. Local Values
28. Datasources
29. Backends - Remote State Storage
30. State Commands
31. CLI Workspaces with local backend
32. CLI Workspaces with remote backend
33. File Provisioner
34. local-exec Provisioner
35. remote-exec Provisioner
36. Null Resource
37. Modules from Public Registry
38. Build Local Module
39. Terraform Cloud - VCS-Driven Worflow
40. Terraform Cloud - CLI-Driven Worflow
41. Terraform Cloud - Share modules in private module registry
42. Migrate State to Terraform Cloud
43. Basic Sentinel Policies
44. Cost Control Sentinel Policies
45. CIS Sentinel Policies
46. State Import
47. Graph
48. Functions
49. Dynamic Expressions
50. Dynamic Blocks


## What will students learn in your course?
- You will learn to master Terraform in a practical perspective with 40+ demo's
- You will learn each and every concept of Terraform (basic to advanced)
- You will learn to write and understand Terraform Resource Behavior in combination with all the Meta-Arguments
- You will learn each and every way (10 types) you can implement the Terraform Input Variables
- You will learn in detail about Terrafrom State, Remote Backends, Terraform Cloud Backends and many Terraform State commands
- You will learn and implement Terraform CLI based workspaces
- You will learn and implement all Terraform Provisioners 
- You will learn and implement Terraform Modules with all 3 types (Public Modules, Local Modules and Private Registry modules on Terraform Cloud)
- You will learn and implement two important usecases on Terraform Cloud (VCS-Driven and CLI-Driven Workflows)
- You will learn about sentinel policies and implement 3 types of sentinel policies
- You will learn and implement Terraform Dynamic Expressions, Dynamic Blocks and Terraform Functions
- You will also learn and implement Terraform Datasources concept

## Are there any course requirements or prerequisites?
- You must have an AWS Cloud account to follow with me for hands-on activities.
- You don't need to have any basic knowledge of Terraform. Course will get started from very very basics of Terraform and take you to very advanced levels



## Who are your target students?
- Infrastructure Architects or Sysadmins or Developers who are planning to master Terraform
- Any beginner who is interested in learning IaC Infrastructure as Code current trending tool Terraform 
- Anyone who want to learn Terraform from a practical perspective 

## Github Repositories used for this course
- [HashiCorp Certified: Terraform Associate](https://github.com/stacksimplify/hashicorp-certified-terraform-associate)
- [Terraform Cloud Demo](https://github.com/stacksimplify/terraform-cloud-demo1)
- [Terraform Private Module Registry](https://github.com/stacksimplify/terraform-aws-s3-website)
- [Terraform Sentinel Policies](https://github.com/stacksimplify/terraform-sentinel-policies)
- [Course PPT Presentation](https://github.com/stacksimplify/hashicorp-certified-terraform-associate/tree/master/presentation)
- **Important Note:** Please go to these repositories and FORK these repositories and make use of them during the course.


## Each of my courses come with
- Amazing Hands-on Step By Step Learning Experiences
- Real Implementation Experience
- Friendly Support in the Q&A section
- 30 Day "No Questions Asked" Money Back Guarantee!

## My Other AWS Courses
- [Udemy Enroll](https://github.com/stacksimplify/udemy-enroll)

## Stack Simplify Udemy Profile
- [Udemy Profile](https://www.udemy.com/user/kalyan-reddy-9/)

# AWS EKS - Elastic Kubernetes Service - Masterclass
[![Image](https://stacksimplify.com/course-images/AWS-EKS-Kubernetes-Masterclass-DevOps-Microservices-course.png "AWS EKS Kubernetes - Masterclass")](https://www.udemy.com/course/aws-eks-kubernetes-masterclass-devops-microservices/?referralCode=257C9AD5B5AF8D12D1E1)


# Azure Kubernetes Service with Azure DevOps and Terraform 
[![Image](https://stacksimplify.com/course-images/azure-kubernetes-service-with-azure-devops-and-terraform.png "Azure Kubernetes Service with Azure DevOps and Terraform")](https://www.udemy.com/course/azure-kubernetes-service-with-azure-devops-and-terraform/?referralCode=2499BF7F5FAAA506ED42)

# Azure - HashiCorp Certified: Terraform Associate - 70 Demos
[![Image](https://stacksimplify.com/course-images/azure-hashicorp-certified-terraform-associate-70demos.png "Azure - HashiCorp Certified: Terraform Associate - 70 Demos")](https://links.stacksimplify.com/azure-hashicorp-certified-terraform-associate)


## Additional References
- [Certification Curriculum](https://www.hashicorp.com/certification/terraform-associate)
- [Certification Preparation](https://learn.hashicorp.com/collections/terraform/certification)
- [Study Guide](https://learn.hashicorp.com/tutorials/terraform/associate-study?in=terraform/certification)
- [Exam Review Guide](https://learn.hashicorp.com/tutorials/terraform/associate-review?in=terraform/certification)
- [Sample Questions](https://learn.hashicorp.com/tutorials/terraform/associate-questions?in=terraform/certification)

Docker Images present on Docker Hub and GitHub Container Registry 

Dear Students,
A few of the students are reporting intermittent download issues for Docker Images hosted on Docker Hub.

This is due to Docker enabling the pull limits on the Docker Hub. We enabled the paid subscription to Docker Hub to increase the limits (5000 pulls per day).

In addition, we have also placed the same Docker Images on GitHub Container Registry.

All the Docker Images which we used in our courses are now also present in GitHub Container Registry (Nothing but the "Packages Tab" on our GitHub Repository).
https://github.com/stacksimplify?tab=packages

Important Note: As usual we don't need any credentials or registered users to access these packages. These are publicly available on our GitHub Repository.

Please find the related screenshot below

In addition, I have created a GitHub Repository docker-hub-to-github-container-registry with Docker Hub vs GitHub Container Registry Docker Images list. Please find its sample screenshot below for reference.

GitHub Repository Link: https://github.com/stacksimplify/docker-hub-to-github-container-registry

Sample Screenshot for reference

Question: What do you need to do when you face an issue with Docker Image download?

Answer:

Just prefix the Docker Image name with "ghcr.io/" in your Kubernetes Deployment or Pod YAML Manifests and it should download the Docker Image from GitHub Container Registry.

In addition, if you want to reference all the Docker Images hosted on GitHub Container Registry, you can go to the Packages section.

In addition, if you want the list of Docker Image names on Docker Hub vs GitHub Container Registry you can go to the GitHub Repo docker-hub-to-github-container-registry to review the table

https://github.com/stacksimplify/docker-hub-to-github-container-registry
Regards, 
Kalyan Reddy Daida