# QAS TF script for all landscape, incl Staging 

## Overview

## Content of setup

The setup comprises the following resources:

- Creation of the SAP BTP subaccount
- Entitlements of one service which is available on all landscape, incl. staging

## Deploying the resources

To deploy the resources you must:

1. Set the environment variables BTP_USERNAME and BTP_PASSWORD to pass credentials to the BTP provider to authenticate and interact with your BTP environments. 

   ```bash
   export BTP_USERNAME=<your_username>
   export BTP_PASSWORD=<your_password>
   ```

2. Change the variables in the `common_sample.tfvars` and `sample.tfvars` file to meet your requirements

   > The minimal set of parameters you should specify (beside user_email and password) is globalaccount (i.e. its subdomain) on live, otherwise specify also the parameters cli_server_url, custom_idp and/or subaccount_name and region in sample.tfvars.

3. Switch to the `step-1` folder

4. Change the variables in `sample.tfvars` file to meet your requirements

5. Initialize the workspace for step 1:

   ```bash
   terraform init
   ```

6. You can check what Terraform plans to apply for step 1 based on your configuration:

   ```bash
   terraform plan -var-file="../common_sample.tfvars" -var-file="sample.tfvars"
   ```

7. Apply your configuration for step 1 to provision the resources:

   ```bash
   terraform apply  -var-file="../common_sample.tfvars" -var-file="sample.tfvars"
   ```

8. Switch to the `step-2` folder. The configuration in this folder adds a cf runtime entitlement to the subaccount created in step 1.

9. Change the variables in `sample.tfvars` file to meet your requirements

   > ⚠ NOTE: You must copy the `subaccount_id` from the output of step 1 and use it for step 2.


5. Initialize the workspace for step 2:

   ```bash
   terraform init
   ```

6. You can check what Terraform plans to apply for step 2 based on your configuration:

   ```bash
   terraform plan -var-file="../common_sample.tfvars" -var-file="sample.tfvars"
   ```

7. Apply your configuration for step 2 to provision the resources:

   ```bash
   terraform apply  -var-file="../common_sample.tfvars" -var-file="sample.tfvars"
   ```
