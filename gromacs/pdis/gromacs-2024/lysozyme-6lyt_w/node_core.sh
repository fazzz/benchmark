#!/bin/sh

nodes=( pdsi22 pdis23 pdis25 pdis26 pdis27 pdis29 )

declare -A cores=(
    ["pdis22"]="12 24"
    ["pdis23"]="12 24 48"
    ["pdis25"]="14 28 56"
    ["pdis26"]="16"
    ["pdis27"]="16 32 64"
    ["pdis29"]="16 32 64 128"
)

declare -A line=(
    ["1"]="bench.job.pdis22_12 bench.job.pdis22_14"
    ["2"]="bench.job.pdis23_12 bench.job.pdis23_24 bench.job.pdis23_48"
    ["3"]="bench.job.pdis25_14 bench.job.pdis25_28 bench.job.pdis25_56"
    ["4"]="bench.job.pdis26_16"
    ["5"]="bench.job.pdis27_16 bench.job.pdis27_32 bench.job.pdis27_64"
    ["6"]="bench.job.pdis29_16 bench.job.pdis29_32 bench.job.pdis29_64 bench.job.pdis29_128"
)

gmx="gmx_mpi"

job_commonname=gx24_lys

#pdis22      24
#pdis23      48
#pdis25      56
#pdis26      16
#pdis27      64
#pdis29     128
