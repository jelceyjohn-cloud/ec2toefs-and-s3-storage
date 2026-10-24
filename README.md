**Multi-AZ Network Storage \& Automated S3 Backup Pipeline**

\-->A highly available, fault-tolerant cloud file infrastructure designed inside a custom AWS VPC network topology. This project establishes a shared network file system accessible concurrently by multiple application servers distributed across distinct data centers (Availability Zones), backed by a high-frequency automation script that mirrors live data into secure object storage every 60 seconds.



**Infrastructure Architecture Diagram**

\-->\[AWS Cloud Architecture](architecture.png)



**Architectural Layering \& Components**



1\. Network Topology (Custom VPC)

\--> Deployed a dedicated Custom VPC split across distinct Availability Zones to prevent network-wide data center outages.

&#x20;   Configured isolated subnets mapped to a custom Route Table linked to an Internet Gateway (IGW) to manage precise ingress/egress boundaries.

&#x20;   Established Security Groups allowing dedicated NFS traffic (Port 2049) securely between the EC2 instances and the Elastic File System endpoints.



2\. Access Control (Identity \& Access Management)

\-->Provisioned an IAM Role defining trusted interaction parameters between EC2, S3, EFS, and VPC.

&#x20;  Linked this role identity directly to the compute instances to permit credential-free AWS CLI authorization, preventing the security risks of hardcoded API keys.



3\. Shared Distributed Storage Engine

\-->Launched Amazon EC2 Linux instances distributed individually into the isolated Availability Zones.

&#x20;  Configured an Amazon EFS (Elastic File System) volume to serve as a shared network drive providing concurrent, low-latency file operations for both instances.



**Step-by-Step EC2 Server Configuration**



1\. Install AWS EFS Utilities \& Mount the Shared Storage File System

\-->Install the necessary utilities for Amazon EFS

&#x20;   cmd: sudo yum install -y amazon-efs-utils

\-->Mount the EFS file system using the specific AWS EFS ID to the target directory

&#x20;   cmd: sudo mount -t efs efsId:/foldername



2.Manual Test Upload to S3 Object Storage

\-->Create a test asset using standard touch commands and push to S3 to verify IAM permissions

&#x20;   cmd: touch filename.txt

&#x20;   cmd: aws s3 cp filename.txt s3://bucketname/



3.Install and Configure the Linux Timing Daemon (Cron)

\-->Install the cron service manager

&#x20;   cmd: sudo yum install cronie -y

\-->Open the cron service scheduler configuration matrix

&#x20;   cmd: crontab -e



4.The Automation Engine ('s3-sync.sh')

\-->Crontab Timing Line Added to the Server

The crontab configuration was saved with the following entry to trigger the s3-sync.sh script automatically every single minute:

text

&#x20;   cmd: \* \* \* \* \* /bin/bash /home/ec2-user/s3-sync.sh >> /var/log/s3\_sync.log 2>\&1







































