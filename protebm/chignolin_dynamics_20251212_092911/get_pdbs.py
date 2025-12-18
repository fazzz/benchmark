import torch
import os
from Bio.PDB import PDBParser, PDBIO
from Bio.PDB.Polypeptide import is_aa
import numpy as np

output_dir = "trajectory_pdbs_c_alpha_only"
os.makedirs(output_dir, exist_ok=True)

parser = PDBParser(QUIET=True)
structure = parser.get_structure("my_structure", "chignolin_cln025.pdb")
chain = [c for c in structure.get_chains()][0]
residues = [r for r in chain.get_residues() if is_aa(r)]
n_res_pdb = len(residues) # 10

ca_atoms = []
for res in residues:
    if 'CA' in res:
        ca_atoms.append(res['CA'])
    else:
        print(f"Warning: C-alpha not found in residue {res.get_id()}. Skipping.")
        
n_ca_in_pdb = len(ca_atoms)

saved = torch.load("dynamics_trajectory.pt")
diffs = [i for i,x in enumerate(saved['all_pos']) if x.shape[0] != saved['all_pos'][0].shape[0]]
start = min(diffs) if len(diffs) > 0 else 0

nbatch = len(saved['all_pos'][start:])
all_pos = torch.stack([x for x in saved['all_pos']][start:]).reshape((nbatch,1) + saved['all_pos'][-1].shape) 
all_t0 = torch.stack([x for x in saved['all_t0']][start:]).reshape((nbatch,1) + saved['all_t0'][-1].shape) 
all_nrgs = torch.stack([x[0] for x in saved['all_scoring_energies']][start:]).view(-1)

# --- PDBIOのセットアップ ---
io = PDBIO()

nbatch = all_pos[0][0].shape[0] # Time Steps (101)
sample_index_to_save = 0          # サンプル 0 を可視化

#print(all_pos.shape)
print(nbatch)

for i in range(nbatch):
    current_pos_ca = all_pos[0][0][i, sample_index_to_save]
    new_coords_np = current_pos_ca.detach().cpu().numpy()
    
    for ca_atom, new_coord in zip(ca_atoms, new_coords_np):
        ca_atom.set_coord(new_coord)
        
    io.set_structure(structure)
    filename = os.path.join(output_dir, f"sample_{sample_index_to_save}_ca_only_frame_{i:04d}.pdb")
    io.save(filename)

print("Done! Check the 'trajectory_pdbs_c_alpha_only' folder.")
print("The output files contain all atoms, but only Cα atoms have updated coordinates.")
