# AWScookbook
Scripts to fill your AWSome life | Karan Kapuria 

## Things-Before-AWSomeness

With InstantR.sh you can create a launch template that contains the configuration information to launch an instance. This bash script can be called from an AWS configured Instance. To configure an AWS instance, login and run,

	aws configure

Example:
AWS Access Key ID : ----

AWS Secret Access Key : -----

Default region name : -----

Default output format : json


## Create Instance from Masters AWS Instance

	./InstantR.sh
 
 This will launch an AWS instance as per your launch template specified in script

## Running Script on AWS Start

When you launch an instance in Amazon EC2, you have the option of passing user data to the instance that can be used to perform common automated configuration tasks and even run scripts after the instance starts. You can pass two types of user data to Amazon EC2: shell scripts and cloud-init directives. 

To specify a user data script, change USER_DATA="file://<script_name>" in InstantR.sh. 

## User Data Template 

I have created a user data script that will auto-mount drives and save disk information. It can also download/upload (IAM Role should permit this) stuff from S3, run downloaded scripts and close instance on process completion. This can be modified to user's need.
  
	USER_DATA="file://LaunchR.sh" 
  
              OR 

	USER_DATA="file://<path>/LaunchR.sh" 
  
