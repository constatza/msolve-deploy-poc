#!/bin/bash
PROCESSES=$1
if [ -z "$PROCESSES" ]
then
    PROCESSES=2
fi
mpirun -np $PROCESSES dotnet /mpidocker/MSolveApp/Msolve.One.MPI/Msolve.One.MPI/bin/Release/net5.0/Msolve.One.MPI.dll