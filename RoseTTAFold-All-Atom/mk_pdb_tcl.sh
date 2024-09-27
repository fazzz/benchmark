#!/bin/sh

cat <<EOF > pdb.tcl
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

mol new {7u7w.pdb} type {pdb}

mol modcolor    0 0 ColorID 0
mol modstyle    0 0 Newcartoon
mol modselect   0 0 protein

mol addrep 0
mol modcolor    1 0 ColorID 1
mol modstyle    1 0 Newcartoon
mol modselect   1 0 not protein

make_rotation_animated {pdb}

quit
EOF

/Applications/VMD\ 1.9.4a57-x86_64-Rev12.app/Contents/vmd/vmd_MACOSXX86_64 -e pdb.tcl
rm *.rgb

ffmpeg -i pdb.gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" pdb.mp4
