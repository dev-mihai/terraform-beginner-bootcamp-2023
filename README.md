## Semantic Versioning

Our project adopts **Semantic Versioning** for release tagging.

**Format:** `MAJOR.MINOR.PATCH` e.g., `1.0.1`

- **MAJOR**: Incompatible API changes
- **MINOR**: Backward-compatible feature additions
- **PATCH**: Backward-compatible bug fixes

🔗 [Learn More about SemVer](https://semver.org/)

---

## Setting Up Terraform CLI

**Note:** Due to recent GPG keyring updates, Terraform CLI installation steps have been revised. Please follow the latest instructions as provided by Terraform's official documentation.

🔗 [Terraform CLI Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

---

### Tailored for Ubuntu

This project is optimized for Ubuntu. Ensure you're using the right Linux distribution or make necessary adjustments.

To check your OS version, run:

```bash
$ cat /etc/os-release
```

🔗 [How to Verify Linux OS Version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

---

### Scripting the Terraform CLI Installation

To tackle GPG depreciation concerns, we've encapsulated the installation steps into a bash script.

📂 **Path:** [./bin/install_terraform_cli](./bin/install_terraform_cli)

Benefits:
- Keeps the Gitpod Configuration tidy
- Simplifies manual debugging and execution
- Enhances reuse across different projects

**Shebang Best Practices:**

Always start your bash scripts with `#!/usr/bin/env bash` to ensure cross-OS compatibility.

🔗 [Learn about Shebangs](https://en.wikipedia.org/wiki/Shebang_(Unix))

**Execution Tips:**

- Directly: `./bin/install_terraform_cli`
- In `.gitpod.yml`: `source ./bin/install_terraform_cli`

**Linux Permissions:**

For script execution, modify permissions:

```bash
chmod u+x ./bin/install_terraform_cli
```

Or:

```bash
chmod 744 ./bin/install_terraform_cli
```

🔗 [Understand Linux Permissions](https://en.wikipedia.org/wiki/Chmod)

---

## Gitpod Workflow Tips

Beware: Initializing in Gitpod won't re-trigger if you reboot an existing workspace.

🔗 [Gitpod Workspace Configuration](https://www.gitpod.io/docs/configure/workspaces/tasks)

---

## Environment Variables (Env Vars) Essentials

**Viewing All Env Vars:** `env`

**Filtering Specific Env Vars:** `env | grep AWS_`

**Setting & Unsetting:**

```bash
export HELLO='world'
unset HELLO
```

**Within Scripts:**

```bash
#!/usr/bin/env bash

HELLO='world'
echo $HELLO
```

**Displaying Vars:** `echo $HELLO`

📌 Remember: New terminal instances might not inherit Env Vars. Make them persistent using `.bash_profile`.

---

## AWS CLI Setup

Install the AWS CLI using: [`./bin/install_aws_cli`](./bin/install_aws_cli)

🔗 [AWS CLI Setup Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Test your AWS credentials:

```bash
aws sts get-caller-identity
```

You should receive a JSON payload confirming your identity.

---

## Dive into Terraform

**Terraform Registry:** A hub for providers and modules.

🔗 [Visit Terraform Registry](https://registry.terraform.io/)

- **Providers:** Interfaces to external APIs enabling resource creation.
- **Modules:** Enables modular, reusable Terraform code.

🔗 [Sample Random Provider](https://registry.terraform.io/providers/hashicorp/random)

**Terraform Commands Overview:**

- **Init:** `terraform init` (Initialize a new project)
- **Plan:** `terraform plan` (Preview changes)
- **Apply:** `terraform apply` (Execute changes)
- **Destroy:** `terraform destroy` (Remove resources)

**File Management:**

- **Lock Files:** Commit `.terraform.lock.hcl` to version control.
- **State Files:** Never commit `.terraform.tfstate` or `.terraform.tfstate.backup` to VCS.

---

## Terraform Cloud Login Workaround in Gitpod

`terraform login` might malfunction in Gitpod's browser-based VSCode. As a remedy:

1. Manually generate a token:
🔗 [Generate Token](https://app.terraform.io/app/settings/tokens?source=terraform-login)

2. Create and edit the credentials file:

```bash
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Replace `YOUR-TERRAFORM-CLOUD-TOKEN` with your token in the below content:

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

For convenience, we've scripted this process:

📂 [Generate Credentials](bin/generate_tfrc_credentials)