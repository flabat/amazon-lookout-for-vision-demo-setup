#!/usr/bin/env bash

set -e

SUFFIX=$(LC_ALL=C tr -dc 'a-z' </dev/urandom | head -c 6 ; echo)

aws s3 mb s3://lookout-vision-$SUFFIX

sudo yum install ImageMagick -y

echo bucket="s3://lookout-vision-$SUFFIX" >> output.txt

# cicruitboard

git clone --depth 1 https://github.com/aws-samples/amazon-lookout-for-vision
find amazon-lookout-for-vision/circuitboard/ -name '*.jpg' -exec mogrify -resize 50%\> {} \;
aws s3 cp --recursive amazon-lookout-for-vision/circuitboard s3://lookout-vision-$SUFFIX/circuitboard
rm -rf amazon-lookout-for-vision/
aws lookoutvision create-project --project-name circuitboard

# capsule

curl ftp://guest:GU.205dldo@ftp.softronics.ch/mvtec_anomaly_detection/capsule.tar.xz -o capsule.tar.xz
tar -xf capsule.tar.xz
rm capsule.tar.xz 
aws s3 cp --recursive capsule/train/good/ s3://lookout-vision-$SUFFIX/capsule/normal/
sudo rm -rf capsule/test/good/  
aws s3 cp --recursive capsule/test/ s3://lookout-vision-$SUFFIX/capsule/anomaly/
sudo rm -rf capsule
aws lookoutvision create-project --project-name capsule

# hazelnut

curl ftp://guest:GU.205dldo@ftp.softronics.ch/mvtec_anomaly_detection/hazelnut.tar.xz -o hazelnut.tar.xz
tar -xf hazelnut.tar.xz
rm hazelnut.tar.xz
aws s3 cp --recursive hazelnut/train/good/ s3://lookout-vision-$SUFFIX/hazelnut/normal/
sudo rm -rf hazelnut/test/good/  
aws s3 cp --recursive hazelnut/test/ s3://lookout-vision-$SUFFIX/hazelnut/anomaly/
sudo rm -rf hazelnut
aws lookoutvision create-project --project-name hazelnut

# metal nut

curl ftp://guest:GU.205dldo@ftp.softronics.ch/mvtec_anomaly_detection/metal_nut.tar.xz -o metal_nut.tar.xz
tar -xf metal_nut.tar.xz
rm metal_nut.tar.xz
aws s3 cp --recursive metal_nut/train/good/ s3://lookout-vision-$SUFFIX/metal_nut/normal/
sudo rm -rf metal_nut/test/good/  
aws s3 cp --recursive metal_nut/test/ s3://lookout-vision-$SUFFIX/metal_nut/anomaly/
sudo rm -rf metal_nut
aws lookoutvision create-project --project-name metal_nut

# pill

curl ftp://guest:GU.205dldo@ftp.softronics.ch/mvtec_anomaly_detection/pill.tar.xz -o pill.tar.xz
tar -xf pill.tar.xz
rm pill.tar.xz
aws s3 cp --recursive pill/train/good/ s3://lookout-vision-$SUFFIX/pill/normal/
sudo rm -rf pill/test/good/  
aws s3 cp --recursive pill/test/ s3://lookout-vision-$SUFFIX/pill/anomaly/
sudo rm -rf pill
aws lookoutvision create-project --project-name pill

# screw

curl ftp://guest:GU.205dldo@ftp.softronics.ch/mvtec_anomaly_detection/screw.tar.xz -o screw.tar.xz
tar -xf screw.tar.xz
rm screw.tar.xz
aws s3 cp --recursive screw/train/good/ s3://lookout-vision-$SUFFIX/screw/normal/
sudo rm -rf screw/test/good/  
aws s3 cp --recursive screw/test/ s3://lookout-vision-$SUFFIX/screw/anomaly/
sudo rm -rf screw
aws lookoutvision create-project --project-name screw