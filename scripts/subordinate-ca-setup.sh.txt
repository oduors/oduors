# Create subordinate CA configuration
cat > subordinate_ca_config.json <<EOF
{
  "KeyAlgorithm": "RSA_2048",
  "SigningAlgorithm": "SHA256WITHRSA",
  "Subject": {
    "Country": "[COUNTRY]",
    "Organization": "[ORGANIZATION]",
    "OrganizationalUnit": "[ORG_UNIT]",
    "State": "[STATE]",
    "CommonName": "[COMMON_NAME] Subordinate CA"
  }
}
EOF

# Create subordinate CA
aws acm-pca create-certificate-authority \
    --certificate-authority-configuration file://subordinate_ca_config.json \
    --certificate-authority-type "SUBORDINATE" \
    --tags Key=Name,Value=[ORGANIZATION]-SubordinateCA \
    --region [REGION]

# Get CSR from ACM PCA
aws acm-pca get-certificate-authority-csr \
    --certificate-authority-arn [SUBORDINATE_CA_ARN] \
    --region [REGION] \
    --output text > subordinate_ca.csr
