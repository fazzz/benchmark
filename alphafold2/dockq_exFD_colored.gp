#!/usr/local/bin/gnuplot

set terminal postscript eps enhanced background rgb 'white' color size 16cm , 10cm  "Times" 20
set output "dockq_exFD_colored.eps"

set encoding iso_8859_1

set tics out

set tics out
set tics font "Times-Roman,20"
set xlabel font "Times-Roman,20"
set ylabel font "Times-Roman,20"
set label font "Times-Roman,20"
set key font "Times-Roman,20"

set noxlabel

set xr [0.0:7]

set ylabel "DockQ"

set yr [-0.2:1.2]

set ytics 0.0,0.1,1.0

set xtics rotate by -90

plot "dockq_ZD.txt"               u (1):3:xtic(1) w p pt 7 ps 1.0 lc rgb "white" notitle, \
     "dockq_ZD.txt"               u (1):3 w boxplot lc rgb "black" notitle, \
     "dockq_omegafold-linker.txt" u (2):3:xtic(1) w p pt 7 ps 1.0 lc rgb "white" notitle, \
     "dockq_omegafold-linker.txt" u (2):3 w boxplot lc rgb "black" notitle, \
     "dockq_AF2-linker.txt"       u (3):3:xtic(1) w p pt 7 ps 1.0 lc rgb "white" notitle, \
     "dockq_AF2-linker.txt"       u (3):3 w boxplot lc rgb "black" notitle, \
     "dockq_AF2_v2.1.1.txt"       u (4):3:xtic(1) w p pt 7 ps 1.0 lc rgb "white" notitle, \
     "dockq_AF2_v2.1.1.txt"       u (4):3 w boxplot lc rgb "black" notitle, \
     "dockq_AF2_v2.2.0.txt"       u (5):3:xtic(1) w p pt 7 ps 1.0 lc rgb "white" notitle, \
     "dockq_AF2_v2.2.0.txt"       u (5):3 w boxplot lc rgb "black" notitle, \
     "dockq_AF2_v2.3.0.txt"       u (6):3:xtic(1) w p pt 7 ps 1.0 lc rgb "white" notitle, \
     "dockq_AF2_v2.3.0.txt"       u (6):3 w boxplot lc rgb "black" notitle, \
     "dockq_T1032_exFD.txt"       u 4:3 w p pt 7 ps 2.0 lc rgb "black" notitle, \
     "dockq_T1038_exFD.txt"       u 4:3 w p pt 7 ps 2.0 lc rgb "blue" notitle, \
     "dockq_T1054_exFD.txt"       u 4:3 w p pt 7 ps 2.0 lc rgb "green" notitle, \
     "dockq_T1078_exFD.txt"       u 4:3 w p pt 7 ps 2.0 lc rgb "red" notitle, \
     "dockq_H1045_exFD.txt"       u 4:3 w p pt 7 ps 2.0 lc rgb "orange" notitle, \
     "dockq_H1065_exFD.txt"       u 4:3 w p pt 7 ps 2.0 lc rgb "pink" notitle

quit
