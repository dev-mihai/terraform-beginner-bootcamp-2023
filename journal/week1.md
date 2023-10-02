# Terraform Beginner Bootcamp 2023: Week 1 Breakdown

## Overview of Root Module Structure

Here is a typical structure for your root module in a Terraform project:

```
PROJECT_ROOT
│
├── main.tf                 # General configurations.
├── variables.tf            # Defines the structure of input variables.
├── terraform.tfvars        # Contains variable values to be injected into the Terraform project.
├── providers.tf            # Specifies required providers and their settings.
├── outputs.tf              # Captures output values.
└── README.md               # Documentation for the root module.
```

Refer to the official [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure).

### Setting Variables in Terraform Cloud 

Terraform allows for two types of variables:
- **Environment Variables**: Set in your terminal (e.g., AWS credentials).
- **Terraform Variables**: Typically set within your `tfvars` file.

Remember, sensitive variables in Terraform Cloud can be concealed in the UI for security.

### Injecting Terraform Input Variables

Explore more on [Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables).

#### Using the `-var` Flag

Override or define input variables using `-var`. For instance, `terraform apply -var user_id="my-user_id"`.

#### Leveraging the `-var-file` Flag

This flag lets you point to a specific file from which Terraform will fetch variable values. It's helpful for maintaining separate variables per environment. Example: `terraform apply -var-file="custom.tfvars"`.

#### Default Variable File: `terraform.tfvars`

This file is Terraform's go-to for default variable values.

#### Automatic Variable Files: `*.auto.tfvars`

Within Terraform Cloud, files named `*.auto.tfvars` are auto-loaded, simplifying variable management, especially in CI/CD setups with Terraform Cloud.

#### Variable Precedence in Terraform

Terraform's variable hierarchy is: command-line flags > environment variables > `auto.tfvars` and its variants > `terraform.tfvars`.

## Addressing Configuration Drift

### Lost State File: What Next?

Misplacing a state file likely means manually dismantling your cloud setup. While `terraform import` can help, it might not cover all resources. Always refer to the relevant Terraform provider documentation for specific import capabilities.

#### Importing Missing Resources Using Terraform 

Use the import command to bring in resources, like: 
`terraform import aws_s3_bucket.bucket bucket-name`.

Dive deeper with [Terraform Import](https://developer.hashicorp.com/terraform/cli/import) and [AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import).

#### Tackling Manual Configurations

If cloud resources are manually tweaked or removed, a Terraform plan intends to revert the setup to its original state, rectifying the drift.

### Using `Terraform Refresh` for Corrections

```sh
terraform apply -refresh-only -auto-approve
```

## Modules in Terraform

### Crafting Terraform Modules

Local module development is ideally done in a `modules` directory, but naming is flexible.

#### Passing Variables to Modules

Modules must declare their variables within a `variables.tf` file.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

#### Source Variations for Modules

Modules can be sourced from different locations:
- Local paths
- GitHub
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

More on [Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources).

## Guidelines for Using ChatGPT with Terraform

Bear in mind, LLMs like ChatGPT might not be updated with the freshest Terraform documentation. It's possible to get older, perhaps even deprecated, examples, especially concerning providers.

## Terraform's File Management

### `fileexists` Function

This built-in function verifies if a file exists.

```tf
condition = fileexists(var.error_html_filepath)
```

Discover more at [fileexists documentation](https://developer.hashicorp.com/terraform/language/functions/fileexists).

### `filemd5` Function

Refer to the [filemd5 documentation](https://developer.hashicorp.com/terraform/language/functions/filemd5).

### Utilizing the `path` Variable in Terraform

Terraform's `path` variable aids in referencing local paths:
- `path.module`: Fetches the current module's path.
- `path.root`: Fetches the root module's path.
  
Learn more about the [Special Path Variable](https://developer.hashicorp.com/terraform/language/

expressions/references#filesystem-and-workspace-info).

For instance:

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```

## Local Variables in Terraform

In Terraform, local variables, commonly referred to as "locals," let us define variables for internal usage within the configuration. They come in handy especially when transforming or restructuring data for use within the configuration.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Learn more about Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Data Sources in Terraform

Data sources in Terraform allow us to retrieve and use details from existing infrastructure or external sources. It's particularly useful when we need information from cloud resources without directly managing them within our configuration.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Learn more about Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## JSON Handling in Terraform

In Terraform's HCL (HashiCorp Configuration Language), you can leverage the `jsonencode` function to represent configurations as inline JSON structures.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

### Changing the Lifecycle of Resources

[Meta Arguments Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)


## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Understanding Provisioners in Terraform

Provisioners provide a mechanism for executing commands on specified compute instances, such as running an AWS CLI command.

However, Hashicorp generally discourages their use, advocating for Configuration Management tools like Ansible as a more suitable alternative. Despite this, the capability is available for users.

[Learn more about Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### The `local-exec` Provisioner

The `local-exec` provisioner triggers commands on the machine where the Terraform operations (like `plan` or `apply`) are being executed.

Example:

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

[Detailed `local-exec` documentation](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

### The `remote-exec` Provisioner

With `remote-exec`, commands can be executed on a targeted machine. To do this, necessary credentials (e.g., SSH details) must be provided for access.

Example:

```tf
resource "aws_instance" "web" {
  # ...

  # Specifies the connection details for
  # generic remote provisioners such as file or remote-exec
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

[Detailed `remote-exec` documentation](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)