#!/bin/bash

## Karan Kapuria 

## Change <access_key> and <secret_key> by respective keys. Add this snippet to your code to auto configure CLI for interaction with s3


#### -------  CREATING AND CONFIGURING AWS CLI  ----------
#### -----------------------------------------------------

mkdir /home/ec2-user/.aws 
cd /home/ec2-user/.aws
echo -e "[default]\naws_access_key_id = <access_key>\naws_secret_access_key = <secret_key>\n" > credentials
echo -e "[default]\noutput = json\nregion = us-east-1\n" > config
sudo chmod 777 credentials
sudo chmod 777 config
