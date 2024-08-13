# Multi-Step Apply with Terraform Providers for SAP BTP and Cloud Foundry

This sample implements a simple multi-step setup using the Terraform Providers for SAP BTP and Cloud Foundry.

The first step creates a new BTP subaccount and CF environment instance, using the first available CF landscape for the subaccount. The outputs can be used 1:1 as inputs for the second step, which creates a new CF space for the org.

The `apply.sh` script in this folder applies both configurations in succession and takes care of providing the outputs of step 1 as input variables for step 2. A few of the inputs are simply passed through to outputs, so that at the end of step 2 all relevant outputs for both steps are returned.

The `destroy.sh` script destroys both configurations.

## Using the Sample

### Install the Terraform Provider for Cloud Foundry

1. Request access to https://github.com/SAP/terraform-provider-cloudfoundry and check out the repository.
2. Follow the "Development Setup" steps: https://github.com/SAP/terraform-provider-cloudfoundry/blob/main/DEVELOPER.md.

### Execute the Sample

1. Create a new file `vars.tfvars` with the following contents In the `step-1` subfolder:
    ```
    custom_ias_tenant = "<<tenant ID/subdomain of custom IAS tenant>>"
    globalaccount     = "<<global account subdomain>>"
    region            = "<<region>>"
    subaccount_name   = "<<desired subaccount name>>"
    ```
2. Export environment variables `BTP_USERNAME`, `BTP_PASSWORD`, `CF_USER`, and `CF_PASSWORD` with your username and password for the custom IdP of your global account.
3. Execute the `apply.sh` script.
4. Verify e.g., in BTP cockpit that a new subaccount with a CF environment instance and a CF space have been created.
5. Clean up by running the `destroy.sh` script.