# Set default region
export AWS_DEFAULT_REGION=[REGION]

# Verify identity
aws sts get-caller-identity

# Verify VPC configuration
aws ec2 describe-vpcs --vpc-ids [VPC_ID]

# Verify subnet availability
aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=[VPC_ID]" \
    --query 'Subnets[*].[SubnetId,AvailabilityZone]' \
    --output table
