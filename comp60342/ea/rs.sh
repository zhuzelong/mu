#!/bin/bash


# CHANGE these seed values 
seed1=27950357
seed2=42604956
seed3=25173627
seed4=20342549
seed5=14202102
seed6=12150498
seed7=85195214
seed8=56030951
seed9=84413753
seed10=73725922

if [ -e rs_runs.txt ]; then
    rm rs_runs.txt
fi
 
echo "random searches running..."
for (( r=1; r<=10; r++ ))
do 
    ./rs $((seed$r)) 100000 >> rs_runs.txt 
    echo "seed="$((seed$r))
done
echo "done"
awk '/Fitness/' rs_runs.txt | awk '{print $1,$3}' > rs_fit.txt 
awk '/Fitness/' rs_runs.txt | awk '{print $1,$5}' > rs_best.txt 

./mean2 10 11 rs_fit.txt > rs_fit.mean.txt
./mean2 10 11 rs_best.txt > rs_best.mean.txt

gnuplot ./plot/plot_rs.plot

echo "============="
awk '/violations=/' rs_runs.txt | awk '{print $2}' > rs_viols.txt
echo "violation statistics"
echo "mean SD SE"
./mean rs_viols.txt
echo "============="

echo "Plot is in plot_rs.ps" 
