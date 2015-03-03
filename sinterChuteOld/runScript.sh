#!/bin/bash 



#mpirun -np 4 /home/luca/LIGGGHTS/LIGGGHTS-PFM-3.0.3/src/lmp_fedora -in in.sinterChute_init -var NTHREADS 1 -var XPROCS 1 -var YPROCS 2 -var ZPROCS 2 -var OMPON 0 -var DCYLDP 5
mpirun -np 4 /home/luca/LIGGGHTS/LIGGGHTS-PFM-3.0.3/src/lmp_fedora -in in.sinterChute_main -var NTHREADS 1 -var XPROCS 1 -var YPROCS 2 -var ZPROCS 2 -var OMPON 0 -var DCYLDP 5
#mpirun -np .... [OPTIONS] -in in.shearCell_loop
# gollum 		: 32 /home/k3b02/k3b1672/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# gollum with module 	: 32 liggghts
# pc 			: 4 /home/luca/liggghts/LIGGGHTS-3-beta-PFM/src/lmp_fedora
# pc 			: 4 /mnt/data_linux/apps/LIGGGHTS/LIGGGHTS-PFM/src/lmp_fedora
#where the last number represents your simulation number 
#beware! thou shall not use the same number twice!
