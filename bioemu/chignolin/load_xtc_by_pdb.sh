#!/bin/bash

opt=( dummy pdb xtc )
nopt=${#opt[*]}
if [ $# -le `expr ${nopt} - 2` ]; then
    echo "USAGE: $0" ${opt[*]:1:${nopt}}
    echo $*
    exit
fi

num=1
while [ $num -le `expr ${nopt} - 1` ]; do
    eval ${opt[$num]}=$1
    shift 1
    num=`expr $num + 1`
done

cat << EOF > temp.tcl
mol new {$pdb} type {pdb} first 0 last -1 step 1 waitfor 1
animate style Loop
mol addfile {$xtc} type {xtc} first 0 last -1 step 1 waitfor 1 0
animate style Loop

mol modselect 0 0 protein
mol modcolor 0 0 chain
mol modstyle 0 0 VDW
mol modmaterial 0 0 Opaque
EOF

alias vmd="/Applications/VMD\ 1.9.4a57-arm64-Rev12.app/Contents/vmd/vmd_MACOSXARM64"
vmd -e temp.tcl
