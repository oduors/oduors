#!/bin/bash

# Security group audit
audit_security_groups() {
    aws ec2 describe-security-group-rules \
        --filters Name=group-id,Values=[SG_ID] \
        --query 'SecurityGroupRules[*].[IpProtocol,FromPort,ToPort,CidrIpv4]'
}

# IAM policy review
review_iam_policies() {
    aws iam get-policy-version \
        --policy-arn [POLICY_ARN] \
        --version-id [VERSION_ID]
}

# HSM user audit
audit_hsm_users() {
    aws-cloudhsm > user list
    aws-cloudhsm > key list --output-format detailed
}

# Run all audits
echo "Running security group audit..."
audit_security_groups

echo "Running IAM policy review..."
review_iam_policies

echo "Running HSM user audit..."
audit_hsm_users
