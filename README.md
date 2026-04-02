# truittjanney.com - Infrastructure

This repository contains the infrastructure code for deploying and managing **truittjanney.com** using Terraform on AWS.

## Overview

This project provisions a fully serverless, production-ready static website architecture using:

* Amazon S3 (static site hosting)
* Amazon CloudFront (CDN)
* Route 53 (DNS management)
* AWS Certificate Manager (TLS/SSL)
* IAM (GitHub Actions deployment role via OIDC)

Terraform remote state is stored in Amazon S3 with state locking enabled via S3 lockfiles.

## Environments

The infrastructure supports two environments:

* **Production**

  * `truittjanney.com`
  * `www.truittjanney.com`

* **Development**

  * `dev.truittjanney.com`

Each environment has its own:

* S3 bucket
* CloudFront distribution
* DNS record

## Authentication

* Local development uses **AWS SSO (IAM Identity Center)**
* CI/CD uses **OIDC with GitHub Actions**
* No long-lived AWS access keys are stored or used

## Infrastructure Components

### S3 Buckets

* `truittjanney-website-prod`
* `truittjanney-website-dev`

Used to store static website assets.

### CloudFront Distributions

* One per environment
* Configured with Origin Access Control (OAC)
* HTTPS enforced

### Route 53

* Alias A records pointing to CloudFront distributions
* DNS validation for TLS/SSL certificates

### ACM (Certificate Manager)

* TLS certificate for:

  * `truittjanney.com`
  * `www.truittjanney.com`

### IAM Role (GitHub Actions)

* Allows:

  * S3 uploads
  * CloudFront cache invalidation
* Uses OIDC (no static credentials)

## Deployment

### Local (Terraform)

```bash
terraform init
terraform plan
terraform apply
```

### GitHub Actions

* Automatically deploys on push
* Uses OIDC to assume AWS role securely

## Project Structure

```
infrastructure/
- acm.tf
- backend.tf
- cloudfront_dev.tf
- cloudfront_prod.tf
- iam.tf
- providers.tf
- route53.tf
- s3.tf
```

## Notes

* `.tfstate` files are not committed (managed remotely in S3)
* Remote Terraform state is stored in S3 bucket `truittjanney-terraform-state`
* State locking is handled using S3 lockfiles (`use_lockfile = true`)
* The backend S3 bucket is pre-provisioned and not managed in this repository
* `.terraform.lock.hcl` is committed for provider version consistency

## Future Improvements

* Monitoring and logging (CloudWatch)

---

## Author

Truitt Janney
