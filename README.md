# client-poc
Companion to PoC doc, with commands and sequence to execute demo.

## Note
Make sure that for the Vault cli commands, both the client and the server use the same version.

##Demo steps:
### Deploy Vault
#### Manual
- Download Vault binary
```
curl xxx
```
- Ensure AWS ports are open
#### Terraform
Architecture for dev:

Load balancer
|
Vault
| Consul (3x)
```
cd /provision-vault/dev/terraform-aws
# If AWS cli not configured, ensure the following are set:
export AWS_DEFAULT_REGION=region
export AWS_ACCESS_KEY_ID=your key id
export AWS_SECRET_ACCESS_KEY= your access key
```
### Configure your working environment:
- Download Vault client
```
curl download vault
```
- Set environment variables:

```
export VAULT_ADDR=[Vault address]
export VAULT_TOKEN=[Vault token] 
```
- Ensure you have TLS certificate

### Test cases:
1. **VE-INIT-001: Vault init** 
2. VE-WEB-002: Verify web ui
3. **VE-TLS-003: TLS config**
4. **VE-HA-004: Failover to standby node**
5. VE-FUNC-005: Create policies and secrets CRUD
6. VE-MTEN-006: Mount endpoints with different permissions
7. \* VE-DYN-007: Dynamic secrets - MySQL
8. \* VE-TEMP-008: Consul Template
9. \* VE-AUTH-009: LDAP
10. \* VE-JAVA-010: Java
11. VE-SSH-011: SSH
12. **VE-PERFREP-012: Performance replication**
13. VE-SENTINEL-013: Sentinel