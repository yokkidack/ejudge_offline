#!/bin/sh

# color preset

RED='\033[0;31m'
NC='\033[0m'
Black='\033[0;30m'
DarkGray='\033[1;30m'
LightRed='\033[1;31m'
Green='\033[0;32m'
LightGreen='\033[1;32m'
BrownOrange='\033[0;33m'
Yellow='\033[1;33m'
Blue='\033[0;34m'
LightBlue='\033[1;34m'
Purple='\033[0;35m'
LightPurple='\033[1;35m'
Cyan='\033[0;36m'
LightCyan='\033[1;36m'
LightGray='\033[0;37m'
White='\033[1;37m'

# po - programm output

rm *.po
py_files=`ls *.py`
cpp_files=`ls *.cpp`
index=0
if ((${#py_files} > 0))
then
    for f in $(ls *.case)
    do
        out="${f%%.*}.po"
        cat $f | python3 $py_files >> $out
    done
fi

if ((${#cpp_files} > 0))
then
    for f in $(ls *.case)
    do
        out="${f%%.*}.po"
        cat $f | g++ -std=c++17 -g -O3 -lm $cpp_files >> $out
    done
fi

index=0
for f in $(ls *.po)
do
    ((index++))
    out=$f
    in="${f%%.*}.out"
    cmp --silent $in $out && echo "${Green}( ${index} ) TEST OK${NC}" || echo "${RED}( ${index} ) TEST FAILED${NC}" #&& echo "${BrownOrange}---------> `cmp $file1 $file2`${NC}"
done
