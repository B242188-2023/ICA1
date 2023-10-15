cd /ICA1/Tcongo_genome/fastqc
for data in $(ls -F -R)
do
gunzip ${data}
done
