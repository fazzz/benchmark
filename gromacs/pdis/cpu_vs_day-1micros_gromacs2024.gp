#!/usr/local/bin/gnuplot

set terminal postscript eps enhanced background rgb 'white' color size 16cm , 10cm  "Times" 20
set output "cpu_vs_day-1micros_gromacs2024.eps"

set encoding iso_8859_1

set tics out

set tics out

set tics   font "Times-Roman,12"
set xlabel font "Times-Roman,20"
set ylabel font "Times-Roman,20"
set label  font "Times-Roman,20"
set key    font "Times-Roman,12"

set style fill solid border lc rgb "black"

se xr [0:130]

set xlabel "Num. of CPU"
set ylabel "days / micro s"

array color[8]

color[1]="red"; color[2]="black"; color[3]="blue"; color[4]="orange"; color[5]="pink";
color[6]="dark-red"; color[7]="grey"; color[8]="dark-blue";

array pdis[8]

pdis[1]="pdis20"; pdis[2]="pdis21"; pdis[3]="pdis22"; pdis[4]="pdis23"; pdis[6]="pdis24";
pdis[5]="pdis25"; pdis[6]="pdis26"; pdis[7]="pdis27"; pdis[8]="pdis29";

f="cpu_vs_days_of_1micros"

d="lysozyme-6lyt_w"

p for [i=1:8] \
    sprintf("gromacs-2024/%s/%s_%s",d,f,pdis[i]) u 1:2 w p pt 7 ps 2.0 lc rgb color[i] \
    title sprintf("%s",pdis[i]), \
  for [i=1:8] \
    sprintf("gromacs-2024/%s/%s_%s",d,f,pdis[i]) u 1:2 w l lt 1 lw 2.0 lc rgb color[i] \
    notitle, \
  for [i=1:8] \
    sprintf("gromacs-2023/%s/%s_%s",d,f,pdis[i]) u 1:2 w p pt 7 ps 2.0 lc rgb color[i] \
    notitle, \
  for [i=1:8] \
    sprintf("gromacs-2023/%s/%s_%s",d,f,pdis[i]) u 1:2 w l lt 0 lw 2.0 lc rgb color[i] notitle

quit
