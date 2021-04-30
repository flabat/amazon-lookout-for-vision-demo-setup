#!/usr/bin/env bash

set -e

SUFIX=$(LC_ALL=C tr -dc 'a-z' </dev/urandom | head -c 6 ; echo)

echo $SUFIX

aws s3 mb s3://lookout-$SUFIX --region

# Prepare sample cicruitboard images

#git clone --depth 1 https://github.com/aws-samples/amazon-lookout-for-vision --force

aws s3 cp --recursive amazon-lookout-for-vision/circuitboard s3://lookout-$SUFIX/circuitboard




