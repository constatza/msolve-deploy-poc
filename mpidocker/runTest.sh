#!/bin/bash

# This script assumes that it has been called from an MPI execution, e.g. `mpirun -np 2 runTest.sh` or `srun -n2 runTest.sh`
dotnet /mpidocker/MSolveApp/Msolve.One.MPI/Msolve.One.MPI/bin/Release/net5.0/Msolve.One.MPI.dll
