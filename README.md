# AWS Three-Tier HA Infrastructure

Production-grade, highly available three-tier AWS architecture provisioned entirely with Terraform. Built as a portfolio project demonstrating real-world Infrastructure as Code practices.

## Architecture Overview

Two Availability Zones (us-east-1a, us-east-1b) throughout every tier for true high availability. Each AZ is fully self-contained with its own NAT Gateway, ensuring no cross-AZ dependency for outbound traffic.

## Infrastructure Components

**Networking**
- VPC (10.0.0.0/16) with DNS hostnames enabled
- 6 subnets across 2 AZs: 2 public (web tier), 2 private (app tier), 2 private (DB tier)
- Internet Gateway for public subnet routing
- 2 NAT Gateways (one per AZ) for private subnet outbound access
- 3 route tables: 1 public, 2 private (per-AZ)

**Compute**
- Web tier: ASG (min 2, max 4) across public subnets, Amazon Linux 2023, Apache
- App tier: ASG (min 2, max 4) across private app subnets, Amazon Linux 2023
- Bastion host in public subnet for secure SSH access to private instances
- All EC2 instances: t2.micro

**Load Balancing**
- Public-facing Application Load Balancer → web tier
- Internal Application Load Balancer → app tier
- ELB health checks on both ASGs

**Database**
- RDS MySQL 8.0, db.t3.micro, Multi-AZ enabled
- Deployed in private DB subnets, not publicly accessible
- DB subnet group spanning both AZs

**Security**
- Layered security groups: each tier only accepts traffic from the tier above it
- Bastion SSH restricted to EC2 Instance Connect CIDR (18.206.107.24/29)
- RDS only accepts MySQL (3306) from app tier security group
- No credentials or sensitive values committed to git (tfvars gitignored)

**State Management**
- Remote state in S3 (versioning + SSE-S3 encryption enabled)
- State locking via S3 native locking

## Repository Structure
## Deployment

**Prerequisites**
- Terraform >= 1.0
- AWS CLI configured with IAM user credentials
- S3 bucket and DynamoDB table for remote state (see State Management above)

**Deploy**
```bash
git clone https://github.com/Sabarish0412/aws-three-tier-ha-infrastructure.git
cd aws-three-tier-ha-infrastructure
terraform init
terraform plan
terraform apply
```

**Destroy**
```bash
terraform destroy
```

> All infrastructure is designed to be torn down and reprovisioned on demand. This is intentional — reproducibility is the proof.

## Deployment Evidence

Infrastructure was fully provisioned and verified before teardown. Evidence captured below.

### Networking Layer (21 resources)
![Terraform Apply - Networking](evidence/networking/apply-complete-21.png)
![VPC](evidence/networking/vpc-available.png)
![Subnets](evidence/networking/subnets-all-6.png)
![NAT Gateways](evidence/networking/nat-gateways-available.png)
![Route Tables](evidence/networking/route-tables-3.png)

### Compute Layer
![EC2 Instances](evidence/compute/ec2-instances-5-running.png)
![Auto Scaling Groups](evidence/compute/asg-both-healthy.png)
![Load Balancers](evidence/compute/alb-both-active.png)
![Target Groups](evidence/compute/target-groups.png)

### Database Layer
![RDS Available](evidence/database/rds-available.png)
![RDS Config - Multi-AZ](evidence/database/rds-config-multiaz.png)

### End-to-End Verification
ALB DNS serving live traffic, load balancing across both AZs:

![Web Tier - us-east-1b](evidence/app-working/web-tier-us-east-1b.png)
![Web Tier - us-east-1a](evidence/app-working/web-tier-us-east-1a.png)

## Key Design Decisions

- **NAT Gateway per AZ** — each AZ is fully self-contained, no cross-AZ dependency for outbound traffic
- **Dual ALB pattern** — web and app tiers scale and fail independently
- **ELB health checks** — ASG replaces instances that fail HTTP health checks, not just OS-level checks
- **Multi-AZ RDS** — automatic failover to standby in second AZ if primary fails
- **Layered security groups** — traffic flows strictly top-down: internet → web ALB → web EC2 → app ALB → app EC2 → RDS

## Tech Stack

Terraform · AWS VPC · EC2 · ALB · ASG · RDS MySQL · S3 · DynamoDB · Amazon Linux 2023 · Apache

