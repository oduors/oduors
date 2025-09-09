#!/bin/bash

echo "=== Daily HSM Health Check ==="
date

# Check HSM status
echo "Checking HSM Status..."
aws cloudhsmv2 describe-clusters \
    --filters clusterIds=[CLUSTER_ID] \
    --query 'Clusters[0].Hsms[*].[HsmId,State,AvailabilityZone]' \
    --output table

# Check backup status
echo "Checking Backup Status..."
aws cloudhsmv2 describe-backups \
    --filters clusterIds=[CLUSTER_ID] \
    --query 'Backups[*].[BackupId,CreateTimestamp,State]' \
    --output table

# Check CloudWatch metrics
echo "Checking CloudWatch Metrics..."
aws cloudwatch get-metric-statistics \
    --namespace AWS/CloudHSM \
    --metric-name HsmUsage \
    --dimensions Name=ClusterId,Value=[CLUSTER_ID] \
    --start-time $(date -u -v-1d +"%Y-%m-%dT%H:%M:%SZ") \
    --end-time $(date -u +"%Y-%m-%dT%H:%M:%SZ") \
    --period 3600 \
    --statistics Average

# Check client connectivity
echo "Checking Client Connectivity..."
sudo /opt/cloudhsm/bin/cloudhsm-cli cluster list

echo "=== Health Check Complete ==="
