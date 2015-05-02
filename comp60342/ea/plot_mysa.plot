set xlabel "Function Evaluations /1000"
set ylabel "Mean Fitness"
set title "My SA Search Results"
set key below
set term post 18
set output "plot_mysa.ps"
plot [][0:4000] "./mysa_best.mean.txt" u ($1/1000):2:4 t "SA BestSoFar" w err, "./mysa_fit.mean.txt" u ($1/1000):2:4 t "SA Instantaneous" w err, "./mysa_best.mean.txt" u ($1/1000):2 t "" w lines lt 1, "./mysa_fit.mean.txt" u ($1/1000):2 t "" w lines lt 2 
set term gif giant size 1020,760
set output "plot_mysa.gif"
replot
