#!/usr/local/bin/gnuplot

set terminal postscript eps enhanced background rgb 'white' color size 14cm , 7cm  "Times" 16
set output "PLDDT.eps"

set encoding iso_8859_1
set tics out

set tics   font "Times-Roman,16"
set xlabel font "Times-Roman,12"
set ylabel font "Times-Roman,16"
set label  font "Times-Roman,16"
set key    font "Times-Roman,16"

set key bottom left

set style fill solid border lc rgb "black"

set xlabel  "Residue"
set ylabel  "PLDDT"

set xrange [0:500]
set xtics 50,50,500
set yrange [00:100]
set ytics 00,10,100

plot "plddt_model_1.txt" u ($0+1):1 w p pt 7 ps 0.5 lc rgb "black" notitle, \
     "plddt_model_1.txt" u ($0+1):1 w l lw 1.0 lc rgb "black" title "model1", \
     "plddt_model_2.txt" u ($0+1):1 w p pt 7 ps 0.5 lc rgb "gray" notitle, \
     "plddt_model_2.txt" u ($0+1):1 w l lw 1.0 lc rgb "gray" title "model2", \
     "plddt_model_3.txt" u ($0+1):1 w p pt 7 ps 0.5 lc rgb "red" notitle, \
     "plddt_model_3.txt" u ($0+1):1 w l lw 1.0 lc rgb "red" title "model3", \
     "plddt_model_4.txt" u ($0+1):1 w p pt 7 ps 0.5 lc rgb "pink" notitle, \
     "plddt_model_4.txt" u ($0+1):1 w l lw 1.0 lc rgb "pink" title "model4", \
     "plddt_model_5.txt" u ($0+1):1 w p pt 7 ps 0.5 lc rgb "blue" notitle, \
     "plddt_model_5.txt" u ($0+1):1 w l lw 1.0 lc rgb "blue" title "model5"

quit
