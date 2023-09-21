# Terraform Beginner Bootcamp 2023 - Week 0

## Semantic Versioning

This project will utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, e.g., `1.0.1`

- **MAJOR** version for incompatible API changes
- **MINOR** version for backward-compatible functionality additions
- **PATCH** version for backward-compatible bug fixes

## Install the Terraform CLI

### Terraform CLI Changes Considerations
The installation instructions for the Terraform CLI have been updated due to changes in the GPG keyring. Therefore, please refer to the latest CLI installation instructions via the Terraform Documentation and update the installation scripting accordingly.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Linux Distribution Considerations

This project is designed for Ubuntu. Please check your Linux Distribution and make the necessary adjustments based on your distribution's requirements.

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While addressing the Terraform CLI GPG deprecation issues, we observed that the bash script steps involved a substantial amount of code. Consequently, we decided to create a bash script for installing the Terraform CLI.

You can find this bash script here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This approach keeps the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- It facilitates easier debugging and manual execution of the Terraform CLI installation.
- It enhances portability for other projects requiring Terraform CLI installation.

#### Shebang Considerations

A Shebang (pronounced Sha-bang) informs the bash script which program should interpret the script, e.g., `#!/bin/bash`

ChatGPT recommends this format for bash: `#!/usr/bin/env bash`

- Ensures portability across different OS distributions.
- Searches the user's PATH for the bash executable.

[Shebang (Unix) on Wikipedia](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations

When executing the bash script, you can use the `./` shorthand notation to execute it, e.g., `./bin/install_terraform_cli`

If you are using a script in .gitpod.yml, you need to specify the program to interpret it, e.g., `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

To make our bash scripts executable, you need to change the Linux permissions to allow execution in user mode:

```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

[Chmod on Wikipedia](https://en.wikipedia.org/wiki/Chmod)

## Gitpod Lifecycle

Exercise caution when using the "Init" step, as it will not rerun if you restart an existing workspace.

[Gitpod Workspaces Tasks Documentation](https://www.gitpod.io/docs/configure/workspaces/tasks)

## Working with Environment Variables

### `env` Command

You can list all Environment Variables (Env Vars) using the `env` command.

To filter specific env vars, use `grep`, e.g., `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal, you can set an env var using `export HELLO='world'`

In the terminal, you can unset an env var using `unset HELLO`

You can set an env var temporarily when running a command, e.g.,

```sh
HELLO='world' ./bin/print_message
```

Within a bash script, you can set an env var without writing `export`, e.g.,

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

You can print an env var using `echo`, e.g., `echo $HELLO`

### Scoping of Env Vars

New bash terminals in VSCode are not aware of env vars set in another window. To make env vars persist across all future bash terminals, set them in your bash profile, e.g., `.bash_profile`

### Persisting Env Vars in Gitpod

You can persist env vars in Gitpod by storing them in Gitpod Secrets Storage:

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml`, but this can only contain non-sensitive env vars.

## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

You can check if your AWS credentials are configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If successful, you should see a JSON payload that looks like this:

```json
{
    "UserId": "AIEAVUO15ZPVHJ5WIJ5KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

You'll need to generate AWS CLI credentials from an IAM User to use AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources its providers and modules from the Terraform registry, located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** provide an interface to APIs that allow you to create resources in Terraform.
- **Modules** enable you to make a large amount of Terraform code modular, portable, and shareable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

You can view a list of all Terraform commands by simply typing `terraform`.

#### Terraform Init

At the start of a new Terraform project, you should run `terraform init` to download the binaries for the Terraform providers that you'll use in this project.

#### Terraform Plan

`terraform plan`

This generates a changeset that shows the state of your infrastructure and what will be changed. You can output this changeset, but often you can just ignore it.

#### Terraform Apply

`terraform apply`

This runs a plan and applies the changeset to your infrastructure. Apply should prompt for

 confirmation (yes or no). To automatically approve an apply, use the `--auto-approve` flag, e.g., `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This destroys resources. You can also use the `--auto-approve` flag to skip the approval prompt, e.g., `terraform apply --auto-approve`

#### Terraform Lock Files

`.terraform.lock.hcl` contains locked versioning for the providers or modules used in this project. The Terraform Lock File **should be committed** to your Version Control System (VCS), e.g., GitHub.

#### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure. This file **should not be committed** to your VCS, as it can contain sensitive data. Losing this file means losing the knowledge of your infrastructure's state. `.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

The `.terraform` directory contains binaries of Terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login`, it launches a bash wizard to generate a token, which doesn't work as expected in Gitpod VSCode in the browser.

The workaround is to manually generate a token in Terraform Cloud:

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create and open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

We have automated this workaround with the following bash script: [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)