#!/bin/bash

module load amdflang-new

REPO_DIR="$(dirname "$(dirname "$(readlink -fm "$0")")")"
cd ${REPO_DIR}/Pragma_Examples/OpenMP/Fortran/2_vecadd/2_vecadd_map

make
./vecadd
make clean
