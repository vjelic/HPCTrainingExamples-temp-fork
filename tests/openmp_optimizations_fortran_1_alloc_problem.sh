#!/bin/bash

module load amdflang-new
export HSA_XNACK=1

REPO_DIR="$(dirname "$(dirname "$(readlink -fm "$0")")")"
cd ${REPO_DIR}/Pragma_Examples/OpenMP/Fortran/optimization/Allocations/1_alloc_problem

make
./alloc_problem
make clean
