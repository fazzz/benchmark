#!/bin/sh

res_90=( $( awk 'BEGIN{FIELDWIDTHS = "6 5 1 4 1 3 1 1 4 1 3 8 8 8 6 6 6 4"}$1~/ATOM/ && $4~/CA/ && $16 > 90.0 {printf"resid %2d or ",$9}' ranked_0.pdb ) )
n1=`expr ${#res_90[@]} - 1`
if [ $n1 -gt 0 ]; then
    unset res_90[$n1]
else
    res_90=( not protein )
fi

res_90_70=( $( awk 'BEGIN{FIELDWIDTHS = "6 5 1 4 1 3 1 1 4 1 3 8 8 8 6 6 6 4"}$1~/ATOM/ && $4~/CA/ && ($16 <= 90.0 && $16 > 70.0){printf"resid %2d or ",$9}' ranked_0.pdb ) )
n2=`expr ${#res_90_70[@]} - 1`
if [ $n2 -gt 0 ]; then
    unset res_90_70[$n2]
else
    res_90_70=( not protein )
fi

res_70_50=( $( awk 'BEGIN{FIELDWIDTHS = "6 5 1 4 1 3 1 1 4 1 3 8 8 8 6 6 6 4"}$1~/ATOM/ && $4~/CA/ && ($16 <= 70.0 && $16 > 50.0){printf"resid %2d or ",$9}' ranked_0.pdb ) )
n3=`expr ${#res_70_50[@]} - 1`
if [ $n3 -gt 0 ]; then
    unset res_70_50[$n3]
else
    res_70_50=( not protein )
fi

res_50=( $( awk 'BEGIN{FIELDWIDTHS = "6 5 1 4 1 3 1 1 4 1 3 8 8 8 6 6 6 4"}$1~/ATOM/ && $4~/CA/ && $16 < 50.0{printf"resid %2d or ",$9}' ranked_0.pdb ) )
n4=`expr ${#res_50[@]} - 1`
if [ $n4 -gt 0 ]; then
    unset res_50[$n4]
else
    res_50=( not protein )
fi

cat <<EOF > ranked_0.tcl
axes location off

proc make_rotation_animated {movie} {
    set frame 0
    for {set i 0} {\$i <= 360} {incr i 10} {
	set filename snap.[format "%04d" \$frame].y.rgb
	render snapshot \$filename
	incr frame
	rotate y by 10
    }

    set filename snap.rgb
    render snapshot \$filename

    for {set i 0} {\$i < 360} {incr i 10} {
	set filename snap.[format "%04d" \$frame].x.rgb
	render snapshot \$filename
	incr frame
	rotate x by 10
    }

    exec convert -loop 1 -delay 10 snap.*y.rgb -delay 30 snap.rgb -delay 10 snap.*x.rgb -delay 100 snap.rgb \$movie.gif
}

mol new {ranked_0.pdb} type {pdb}

mol modcolor    0 0 ColorID 0
mol modstyle    0 0 Newcartoon
mol modselect   0 0 ${res_90[@]}

mol addrep 0
mol modcolor    1 0 ColorID 10
mol modstyle    1 0 Newcartoon
mol modselect   1 0 ${res_90_70[@]}

mol addrep 0
mol modcolor    2 0 ColorID 4
mol modstyle    2 0 Newcartoon
mol modselect   2 0 ${res_70_50[@]}

mol addrep 0
mol modcolor    3 0 ColorID 3
mol modstyle    3 0 Newcartoon
mol modselect   3 0 ${res_50[@]}

make_rotation_animated {ranked_0}

quit
EOF

/Applications/VMD\ 1.9.4.app/Contents/vmd/vmd_MACOSXX86 -e ranked_0.tcl

rm *.rgb

ffmpeg -i ranked_0.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" ranked_0.mp4
