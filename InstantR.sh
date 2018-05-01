#!/bin/bash

## C R E A T E   I N S T A N  C E

## --------------------- SPECIFY THE PARAMETERS ----------------

## -- IMAGE AND INSTANCE TYPES

IMAGE_ID="ami-1853ac65" ; ## Linux-AMI 

INSTANCE_TYPE="c4.4xlarge" ;

REGION="us-east-1" ;


## -- SECURITY DETAILS

KEY_NAME="*****" ;

SUBNET_ID="******" ;

SECURITY_GROUP_ID="*******" ;

I_AM_ROLE="Name=*******" ;


## -- SHUTDOWN BEHAVIOR

SHUTDOWN_BEHAVIOR="terminate" ;

## -- FILE TO RUN

USER_DATA="file://******" ; ## Script to Run on Start


## -- CHANGE STORAGE AND INSTANCE TAGS BELOW 

aws ec2 run-instances --image-id $IMAGE_ID --count 1 --region $REGION --instance-type $INSTANCE_TYPE  --key-name $KEY_NAME --subnet-id $SUBNET_ID --security-group-ids $SECURITY_GROUP_ID --iam-instance-profile $I_AM_ROLE --block-device-mappings "[{\"DeviceName\":\"/dev/sdf\",\"Ebs\":{\"VolumeSize\":10,\"DeleteOnTermination\":true}}]" --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=*****}]' 'ResourceType=volume,Tags=[{Key=Name,Value=******]' --user-data $USER_DATA --instance-initiated-shutdown-behavior $SHUTDOWN_BEHAVIOR  


