#!/bin/bash -l

#-----------------------------------------------------------------
# Serial job , requesting 1 core , 2800 MB of memory per job
#-----------------------------------------------------------------

#SBATCH --job-name=test
#SBATCH --output=output/test.%j.out 
#SBATCH --error=output/test.%j.err 
#SBATCH --ntasks=4 # Total number of tasks
#SBATCH --gres=gpu:1 # gpu per node
#SBATCH --nodes=2 # Total number of nodes requested
#SBATCH --ntasks-per-node=2 # Tasks per node
#SBATCH --cpus-per-task=1 # Threads per task
#SBATCH --mem=2800 # Memory per job in MB
#SBATCH -t 00:10:00 # Run time (hh:mm:ss) - (max 48h)
#SBATCH --partition=el7gpu #el7thin el7taskp or el7gpu # Submit queue
#SBATCH -A pa230604 # Accounting project


# Load any necessary modules
module purge
module load gnu
module load intelmpi
module load cuda

# ENVIRONMENT
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/bin:$DOTNET_ROOT:$DOTNET_ROOT/tool
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

#export LD_LIBRARY_PATH=$HOME/libs/tensorflow/lib:$LD_LIBRARY_PATH
#export LD_DEBUG=libs

# PREPARE DIRS
cd $HOME/msolve-deploy-poc/MSolveApp/
mkdir -p ./output

srun dotnet test ./Msolve.One.MPI/





