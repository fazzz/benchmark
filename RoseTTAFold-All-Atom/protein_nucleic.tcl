axes location off

proc make_rotation_animated {movie} {
    set frame 0
    for {set i 0} {$i <= 360} {incr i 10} {
	set filename snap.[format "%04d" $frame].y.rgb
	render snapshot $filename
	incr frame
	rotate y by 10
    }

    set filename snap.rgb
    render snapshot $filename

    for {set i 0} {$i < 360} {incr i 10} {
	set filename snap.[format "%04d" $frame].x.rgb
	render snapshot $filename
	incr frame
	rotate x by 10
    }

    exec convert -loop 1 -delay 10 snap.*y.rgb -delay 30 snap.rgb -delay 10 snap.*x.rgb -delay 100 snap.rgb $movie.gif
}

mol new {7u7w_protein_nucleic.pdb} type {pdb}

mol modcolor    0 0 ColorID 0
mol modselect   0 0 protein
mol modstyle    0 0 Newcartoon

mol addrep 0
mol modcolor    1 0 ColorID 1
mol modselect   1 0 not protein
mol modstyle    1 0 Newcartoon

mol addrep 0
mol modselect   2 0 not protein
mol modcolor    2 0 ColorID 1

make_rotation_animated {protein_nucleic}

quit
