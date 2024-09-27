#!/usr/local/bin/gnuplot

set terminal postscript eps enhanced background rgb 'white' color size 24cm , 12cm  "Times" 20
set output "cpu_vs_ns-day.eps"

set encoding iso_8859_1

set tics out
set multiplot layout 2,3

set tics out

set tics   font "Times-Roman,12"
set xlabel font "Times-Roman,20"
set ylabel font "Times-Roman,20"
set label  font "Times-Roman,20"
set key    font "Times-Roman,12"

set style fill solid border lc rgb "black"

set key bottom

se xr [0:90]

set xlabel "Num. of CPU"
set ylabel "ns / day"

set label 1 at graph 0.1,0.9 "(a)" #"14,948 atoms"

array color[9]

color[1]="red"; color[2]="black"; color[3]="blue"; color[4]="orange"; color[5]="pink";
color[6]="dark-red"; color[7]="grey"; color[8]="dark-blue"; color[9]="dark-orange";

array pdis[9]

pdis[1]="pdis17"; pdis[2]="pdis18"; pdis[3]="pdis19"; pdis[4]="pdis20"; pdis[5]="pdis21";
pdis[6]="pdis22"; pdis[7]="pdis24"; pdis[8]="pdis25"; pdis[9]="pdis26";

d="chignolin_w"

p for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    title sprintf("%s",pdis[i]), \
  for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 1 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 0 lc rgb color[i] notitle

set label 1 at graph 0.1,0.9 "(b)" #"35,984 atoms"

d="lysozyme-6lyt_w"

p for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    title sprintf("%s",pdis[i]), \
  for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 1 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 0 lc rgb color[i] notitle

set label 1 at graph 0.1,0.9 "(c)" #"149,052 atoms"

d="SAM50TOM40_wm_HMR"

p for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    title sprintf("%s",pdis[i]), \
  for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 1 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 0 lc rgb color[i] notitle

set label 1 at graph 0.1,0.9 "(d)" #"154,885 atoms"

d="SAM50TOM40_wm"

p for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    title sprintf("%s",pdis[i]), \
  for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 1 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 0 lc rgb color[i] notitle

set label 1 at graph 0.1,0.9 "(e)" #"274,917 atoms"

d="Ku50+DNA-1jey_w"

p for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    title sprintf("%s",pdis[i]), \
  for [i=1:9] \
    sprintf("gromacs-2023/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 1 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w p pt 7 ps 1.0 lc rgb color[i] \
    notitle, \
  for [i=1:9] \
    sprintf("gromacs-2022/%s/performance_%s",d,pdis[i]) u 1:2 w l lt 0 lc rgb color[i] notitle

quit
