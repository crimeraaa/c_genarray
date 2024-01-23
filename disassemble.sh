#!/usr/bin/env bash
# Make this an executable via: `chmod +x ./disassemble.sh`

if [[ $# -ne 1 ]]; then
    echo "Need exactly 1 command-line argument!"
    printf "Usage: %s <object_file>\n" $0
    exit 1
fi

obj=$1
# Use an array of strings as whitespaces are considered separate arguments.
args=(
    "-Mintel"
    "--disassemble"
    "--source"
    "--source-comment=\;"
    "--wide"
    "--visualize-jumps=extended-color"
    "--disassembler-color=on" # Can't use terminal, extended looks wacky
)

# https://www.freecodecamp.org/news/bash-array-how-to-declare-an-array-of-strings-in-a-bash-script/
# https://stackoverflow.com/a/69110187
# ${args[@]} means expand each element of the array into one line
eval "objdump ${args[@]} $obj | less --RAW-CONTROL-CHARS"
