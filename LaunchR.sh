#!/bin/bash


init_files()
{

## AWS S3 PATHS 

SAMPLE_NAME="*****" ;

PROJECT_NAME="*****" ;

SAMPLE_FORWARD="****" ;

SAMPLE_REVERSE="****" ;

PIPELINE_PATH="****" ;

REFERENCE_PATH="***" ;

SAMPLE_FILENAME_FWD="****";

SAMPLE_FILENAME_RWS="****";

UPLOAD_DIR="*****" ; 

}


#### -------------------  UPDATE AWS  --------------------
#### -----------------------------------------------------

yum update -y
service httpd start
chkconfig httpd on
sudo pip install awscli
sudo yum install gcc -y ;
sudo yum install ncurses-devel -y ;
sudo yum install zlib-devel -y ;
sudo yum install bzip2-devel -y ; 
sudo yum install xz-devel -y ;
sudo yum install perl-GDGraph.noarch -y
sudo yum install tree -y ;

## Removing Java and Reinstalling v 1.8.0

rpm -aq | grep -i jdk | xargs sudo yum remove -y ;
sudo yum install java-1.8.0-openjdk* -y ;



#### --------------  AUTO-MOUNT STORAGE  -----------------
#### -----------------------------------------------------

nohup lsblk > avail_disk.log
storage_name=$(tail -n 1 avail_disk.log | awk '{print $1}')
sudo mkfs -t ext4 /dev/$storage_name
sudo mkdir /volumes  												##---------------------CREATE VOLUMES DRIVE TO MOUNT THE EBS STORAGE
sudo mount /dev/$storage_name /volumes


#### ---------  GET AND STORE SYSTEM STRUCTURE  ----------
#### -----------------------------------------------------

nohup df -h > disk_structure.log


#### -----  GIVE PERMISSION FOR CREATING FOLDERS  ---------
#### -----------------------------------------------------

cd /
chmod -R 777 /volumes


#### -------  CREATING AND CONFIGURING AWS CLI  ----------
#### -----------------------------------------------------

mkdir /home/ec2-user/.aws 
cd /home/ec2-user/.aws
echo -e "[default]\naws_access_key_id = <aws_access_key_here>\naws_secret_access_key = <aws_secret_key_here>\n" > credentials
echo -e "[default]\noutput = json\nregion = us-east-1\n" > config
sudo chmod 777 credentials
sudo chmod 777 config


#### --- DOWNLOADING SAMPLES AND INSTALLTION FILES -------
#### -----------------------------------------------------

init_files ;  ##-------- Call the INIT function

## -- copy pipeline files 

nohup aws s3 cp $PIPELINE_PATH $WORK_DIR --recursive --region us-east-1 > Pipeline.copy.log 

## -- copy samples to directory

nohup aws s3 cp $SAMPLE_FORWARD $WORK_DIR --recursive --region us-east-1 > Sample_Forward.copy.log 

nohup aws s3 cp $SAMPLE_REVERSE $WORK_DIR --recursive --region us-east-1 > Sample_Reverse.copy.log 

## -- making directory for reference genome

mkdir $WORK_DIR/genome

sudo chmod 777 -R WORK_DIR/genome

nohup aws s3 cp $REFERENCE_PATH $WORK_DIR/genome --recursive --region us-east-1 > Ref_Genome.copy.log


#### -------- INSTALLING PIPELINE AND TOOLS --------------
#### -----------------------------------------------------

##**** Install Module of Pipeline *******

### --------------- RUNNING PIPELINE --------------------
#### -----------------------------------------------------


##******* Pipeline Call *****


#### --------------- COLLECTING STATISTICS ---------------
#### -----------------------------------------------------

nohup df -h > Disk_Usage.log
nohup tree -h > File_Tree.log


#### -------- DELETING REFERENCES and PIPELINE -----------
#### -----------------------------------------------------

sudo rm -r $WORK_DIR/genome

mkdir AWS_logs
mv *.log AWS_logs/
sudo cp /var/log/cloud-init-output.log AWS_logs/   ## Getting the whole System Log

curl http://169.254.169.254/latest/meta-data/instance-id > instance.id

echo -e "\n" >> instance.id


#### --------------- UPLOADING DATA 2 AWS ----------------
#### -----------------------------------------------------

nohup aws s3 cp $WORK_DIR $UPLOAD_DIR --recursive --region us-east-1 > Final_Upload.copy.log


#### --------------- TERMINATING INSTANCE ----------------
#### -----------------------------------------------------

while read line ; do aws ec2 stop-instances --instance-ids $line ;  done <instance.id 


		


