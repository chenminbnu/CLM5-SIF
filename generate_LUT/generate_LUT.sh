#!/bin/zsh
#SBATCH -N 1
#SBATCH -t 1500
#SBATCH -p slurm
#SBATCH -A sif
#SBATCH -J CLM_LUT
#SBATCH -o CLM_LUT.out

cd /pic/projects/sif/dalei/CLM_escape_ratio/PROSAIL
source  /etc/profile.d/modules.sh
module purge
module load matlab

echo start
matlab -r -nodesktop -nosplash  "build_LUT"
