#!/bin/bash
# Update system packages
dnf update -y

# Install Apache web server
dnf install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Create a simple index page to verify the instance is serving traffic
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /var/www/html/index.html << EOF
<html>
<body>
<h1>three-tier-ha - Web Tier</h1>
<p>Instance ID: ${INSTANCE_ID}</p>
<p>Availability Zone: ${AZ}</p>
</body>
</html>
EOF
