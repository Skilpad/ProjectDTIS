#!/bin/sh

fname=$(readlink -f $1)

cd `dirname $0`
cd ..

echo "set iir_name $fname" > cmd.tcl
echo "set period $2" > cmd.tcl

eda snps dc_shell -x \"source SCRIPTS/iir_sol.tcl\"

rm cmd.tcl
