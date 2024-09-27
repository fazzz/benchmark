#!/usr/local/bin/gnuplot

set terminal postscript eps enhanced background rgb 'white' color size 20cm , 10cm  "Times" 20
set output "cpu_vs_ns-day.eps"

set encoding iso_8859_1

set tics out
set multiplot layout 2,3

set size square
set tics out
set tics font "Times-Roman,20"
set xlabel font "Times-Roman,20"
set ylabel font "Times-Roman,20"
set label font "Times-Roman,20"
set key font "Times-Roman,20"

set style fill solid border lc rgb "black"

set xlabel "Bum. of CPU"

set ylabel "ns / day"

set label 1 at graph 0.1,0.9 "14,948 atoms"

plot "div_vs_chi.txt" u 1:3 w p pt 7 ps 2.0 lc rgb "red" notitle

set ylabel "{/Symbol c}^{2}(Target)"

set label 1 at graph 0.1,0.9 "(b)"

plot "div_vs_chi.txt" u 1:2 w p pt 7 ps 2.0 lc rgb "black" notitle

#set ylabel "{/Symbol c}@^{2}_{0}-{/Symbol c}^{2} (Total) , {/Symbol c}@^{2}_{0}-{/Symbol c}^{2} (Target)"
set ylabel "{/Symbol c}^{2} (Not-Target)"

set label 1 at graph 0.1,0.9 "(c)"

set yr [ 35:45 ]

plot "div_vs_chi.txt" u 1:($3-$2) w p pt 7 ps 2.0 lc rgb "black" notitle

quit
