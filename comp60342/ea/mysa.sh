#!/bin/bash


# CHANGE these seed values 
seed1=24553597
seed2=51795141
seed3=161103977
seed4=232865109
seed5=214000415

if [ -e mysa_runs.txt ]; then
    rm mysa_runs.txt
fi
 
echo "my sa searches running..."

for (( r=1; r<=5; r++ ))
do 
    ./mysa $((seed$r)) 500000 10 0.01 500000 >> mysa_runs.txt
    echo "seed="$((seed$r))
done
echo "done"

awk '/Fitness/' mysa_runs.txt | awk '{print $1,$3}' > mysa_fit.txt 
awk '/Fitness/' mysa_runs.txt | awk '{print $1,$5}' > mysa_best.txt 

./mean2 5 51 mysa_fit.txt > mysa_fit.mean.txt
./mean2 5 51 mysa_best.txt > mysa_best.mean.txt

gnuplot plot_mysa.plot


echo "====== SA ======"
awk '/violations=/' mysa_runs.txt | awk '{print $2}' > mysa_viols.txt
echo "violation statistics"
echo "mean SD SE"
./mean mysa_viols.txt
echo 
echo "Plot is in plot_mysa.ps" 

