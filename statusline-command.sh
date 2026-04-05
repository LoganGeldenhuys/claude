#!/usr/bin/env bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')
dirname=$(basename "$cwd")
user=$(whoami)
printf '\e[1;37m[%s@%s]\e[0m' "$user" "$dirname"
