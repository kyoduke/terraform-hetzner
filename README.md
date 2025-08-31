# Usage

Create the tfvars from the example file
```bash
cp terraform.auto.tfvars.example terraform.auto.tfvars
```

Update the <strong>terraform.auto.tfvars</strong> file with your Hetzner Cloud Token

```hcl
hcloud_token = "<YOUR TOKEN>"
```

Initialize the terraform provider
```bash
terraform init
```

Apply the changes **(review and hit yes to apply)**
```bash
terraform apply
```

After you are done testing, don't forget to destroy you infra **(review and hit yes to apply)**
```bash
terraform apply -destroy
```

## Todo: 

- Make it a module so it's easier to create multiple instances if needed
- Update README to explain how to change configuration