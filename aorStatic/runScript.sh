#! /bin/bash
#mpirun -np .... [OPTIONS] -in in.shearCell_init_packing
#mpirun -np .... [OPTIONS] -in in.shearCell_loop

mpirun -np 2 liggghts -in in.repose_init_packing
mpirun -np 2 liggghts -in in.repose_loop -var iden 0011
#liggghts -in in.repose_angle -var iden 0011
#liggghts -in in.repose_angle -var iden 0012
# gollum 		: 32 /home/k3b02/k3b1672/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# gollum with module 	: 32 liggghts
# pc 			: 4 /home/luca/liggghts/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# pc 			: 4 /mnt/data_linux/apps/LIGGGHTS/LIGGGHTS-PFM/src/lmp_fedora
#where the last number represents your simulation number 
#beware! thou shall not use the same number twice!
