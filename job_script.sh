#!bin/bash
#SBATCH --nodes=2
#SBATCH --time=00:20:00
#SBATCH --ntasks=24
#SBATCH --job-name=gen_bts
#SBATCH --output=gen_bts.%j.out

module purge
module load matlab
matlab B_TS_FF_Gen.m
