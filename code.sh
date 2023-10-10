#!/bin/bash

#mkdir /home/s2558632/ICA1/fastqc_out
cd /home/s2558632/ICA1/fastqc

for data in $(ls -F -R)
do
fastqc -o /home/s2558632/ICA1/fastqc_out -f fastq -t 10 ${data}
done
