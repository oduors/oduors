# Create CloudWatch Log Group
aws logs create-log-group \
    --log-group-name /aws/cloudhsm/[CLUSTER_ID]

# Monitor HSM metrics
aws cloudwatch get-metric-statistics \
    --namespace AWS/CloudHSM \
    --metric-name HsmUsage \
    --dimensions Name=ClusterId,Value=[CLUSTER_ID]

# Create CloudWatch Dashboard
cat > hsm-dashboard.json <<EOF
{
    "widgets": [
        {
            "type": "metric",
            "properties": {
                "metrics": [
                    ["AWS/CloudHSM", "HsmUsage", "ClusterId", "[CLUSTER_ID]"],
                    ["AWS/CloudHSM", "IntegrityCheckStatus", "ClusterId", "[CLUSTER_ID]"]
                ],
                "period": 300,
                "stat": "Average",
                "region": "[REGION]",
                "title": "HSM Health Metrics"
            }
        }
    ]
}
EOF

aws cloudwatch put-dashboard \
    --dashboard-name HSM-Monitoring \
    --dashboard-body file://hsm-dashboard.json
