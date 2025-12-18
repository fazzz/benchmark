#!/usr/local/bin/gnuplot

set terminal postscript eps enhanced background rgb 'white' color size 20cm , 12cm  "Times" 20
set output "cpu_vs_ns-day.eps"

set encoding iso_8859_1

set tics out
set multiplot layout 1,2

set tics out

set tics   font "Times-Roman,20"
set xlabel font "Times-Roman,20"
set ylabel font "Times-Roman,20"
set label  font "Times-Roman,20"
set key    font "Times-Roman,20"

set style fill solid border lc rgb "black"

set key top

se xtics 1,1,5
se xr [0.9:5]

se yr [350:700]

set xlabel "Num. of NODES"
set ylabel "ns / day"

set label 1 at graph 0.1,0.9 "lysozyme"

p "performance_pegasus_gx24_t4l" u 1:4 w p pt 7 ps 2.0 lc rgb "red" notitle, \
  "performance_pegasus_gx24_t4l" u 1:4 w l lt 1 lc rgb "red" title "pegasus, gmx2024.4", \
  "performance_pegasus_gx25_t4l" u 1:4 w p pt 7 ps 2.0 lc rgb "orange" notitle, \
  "performance_pegasus_gx25_t4l" u 1:4 w l lt 1 lc rgb "orange" title "pegasus, gmx2025.1", \
  "performance_miyabi_gx24_t4l" u 1:4 w p pt 7 ps 2.0 lc rgb "blue" notitle, \
  "performance_miyabi_gx24_t4l" u 1:4 w l lt 1 lc rgb "blue" title "miyabi, gmx2024.4"

se yr [0:250]

set label 1 at graph 0.1,0.9 "Protein-DNA"

p "performance_pegasus_gx24_KuDNA" u 1:4 w p pt 7 ps 2.0 lc rgb "red" notitle, \
  "performance_pegasus_gx24_KuDNA" u 1:4 w l lt 1 lc rgb "red" title "pegasus, gmx2024.4", \
  "performance_miyabi_gx24_KuDNA" u 1:4 w p pt 7 ps 2.0 lc rgb "blue" notitle, \
  "performance_miyabi_gx24_KuDNA" u 1:4 w l lt 1 lc rgb "blue" title "miyabi, gmx2024.4"

quit
