#!/bin/bash

cd /home/s2558632/ICA1/fastq

for data in $(ls -F -R)
do
echo fastqc -o ./fastqc_out -f fastq -t 10 ${data}
done
