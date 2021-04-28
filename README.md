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