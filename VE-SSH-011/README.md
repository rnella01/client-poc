## Commands

```
# Vault issuing pki certificates:
vault secrets enable pki
vault write pki/root/generate/internal \
    common_name=my-website.com \
    ttl=8760h

vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \     crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"

vault write pki/roles/my-role \
    allowed_domains=my-website.com \
    allow_subdomains=true \
    max_ttl=72h

vault write pki/issue/my-role \
    common_name=www.my-website.com

---
# Vault signing ssh certificates
vault secrets enable -path=ssh-client-signer ssh

# Generate or register existing certificate
vault write ssh-client-signer/config/ca generate_signing_key=true
# Or, if you have your own certificate already...
# vault write ssh-client-signer/config/ca \
#    private_key="..." \
#    public_key="..."

# In the target instance, retrieve and install the certificate:
ssh -i pem ec2-user@IP
# Reading the public key does not require authentication:
export VAULT_ADDR=
sudo curl -o /etc/ssh/trusted-user-ca-keys.pem $VAULT_ADDR/v1/ssh-client-signer/public_key
# Or, using CLI
# vault read -field=public_key ssh-client-signer/config/ca > /etc/ssh/trusted-user-ca-keys.pem

# Add the path to the trusted keys
# /etc/ssh/sshd_config
# ...
TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem

Restart the SSH service to pick up the changes.
sudo  service sshd restart

# Back on the original machine
# This is where you define the TTL of the signed key and user
vault write ssh-client-signer/roles/my-role -<<"EOH"
{
  "allow_user_certificates": true,
  "allowed_users": "*",
  "default_extensions": [
    {
      "permit-pty": ""
    }
  ],
  "key_type": "ca",
  "default_user": "ec2-user",
  "ttl": "30m0s"
}
EOH

# On the machine that wants to connect:
ssh-keygen -t rsa -C "user@example.com"
vault write ssh-client-signer/sign/my-role \
    public_key=@test_id_rsa.pub

# Write the result to a cert file:
vault write -field=signed_key ssh-client-signer/sign/my-role     public_key=@test_id_rsa.pub > signed-cert.pub

# ssh into instance
ssh -i signed-cert.pub -i test_id_rsa ec2-user@ec2-34-200-246-75.compute-1.amazonaws.com
```
