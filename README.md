# cyber-security-windows-sandbox
Build a windows domain in AWS with terraform with a DC and WEC event forwarding.

This code borrows heavily from [mordor](https://github.com/OTRF/mordor).
The original terraform AWS implementation has since
been removed from the mordor repo so we have
reimplemented much of the same code and started to
migrate things like the AMIs as required.

Our scenario is currently much simpler. We need
only a DC and a WEC with no workstations or the
threat hunting tools.

## Terraform

Variable settings are hard coded into the
`variables.tf` for the deployment so tfvar files
are not necessary.

```buildoutcfg
cd deployments/[account]
terraform init
terraform apply
```

After deploying the EC2 instances, a series of remote-exec tasks are run using
WinRM. These are chained together using `depends_on` to ensure they happen in
the correct sequence. The reason for this is that several of the Windows Server
setup operations require you to reboot. Each remote-exec ends with a
`Restart-Computer -Force` and then the next task connects and retries until the
server comes back online.

### Exec roles

The EC2 instance profiles and secrets manager secret is separated into a
different state file.

For secrets manager this is because when you delete a secret it doesn't get
deleted - it gets scheduled for deletion in 30 days and you can't create another
secret with the same name while it still exists.

Instead what we do is create the secret once and then create secret versions
when the terraform is applied.

For the instance roles this is to avoid breaking the trust relationships.
Although trust relationships list an IAM ARN, they actually work based on an
internal AWS ID which changes if the role is recreated. If you recreated the
IAM role as part of a destroy/apply it would break the trust and the instance
would no longer be able to assume the role to access the S3 config. 

## Connecting

The terraform enables connection remotely using both WinRM and RDP.
The connections are allow-listed to the GDS public IPs and the EIPs of our
concourse workers to enable the terraform to run in the pipeline.

The terraform outputs the public IP for each instance
The RDP passwords for each instance are stored in SSM.

You can't explicitly set the Administrator password for EC2 in terraform so it
is set automatically by AWS and retrieved and decrypted using `get_password_data`
and `rsadecrypt`.

The SSH key for the EC2 instance is used to decrypt the password_data.
This is created using `scripts/Local/create_keypair.sh`. The reason for this is
that it requires a keypair with `-----BEGIN RSA PRIVATE KEY-----` instead of the
current `ssh-keygen` default format `-----BEGIN OPENSSH PRIVATE KEY-----`.

Once the terraform has run the SSH key can be retrieved from secrets manager using
`scripts/Local/retrieve_keypair.sh`. This means that one person can apply and
another can destroy or that concourse can destroy without requiring that the
keypair is still available from an earlier output.

## Packages

The script installs a Splunk MSI from the same bucket where the forwarder config
is as well as a Windows Tar binary for unpacking the apps. Tar is avalable in
Windows Server 2019 but not in 2016.
