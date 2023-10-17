cd /home/s2558632/ICA1/fastqc
for data in $(ls -F -R)
do
gunzip ${data}
done
