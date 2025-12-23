mol new {samples.xtc} type {pdb} first 0 last -1 step 1 waitfor 1
animate style Loop
mol addfile {topology.pdb} type {xtc} first 0 last -1 step 1 waitfor 1 0
animate style Loop

mol modselect 0 0 protein
mol modcolor 0 0 chain
mol modstyle 0 0 VDW
mol modmaterial 0 0 Opaque
