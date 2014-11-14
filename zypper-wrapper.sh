#!/bin/bash
# ./zypper-wrapper.sh
# a very simple zypper wrapper
# tests if `zypper in $1` failed to find $1 package if it failed it runs `zypper se $1`
# Copyright (c) 2014 Sahal Ansari - github@sahal.info
# License: MIT (see LICENSE)

set -e

# the scripts directory
DIR="$( cd "$( dirname "$0" )" && pwd )"
# REQUIRED: directory to store tmp files
TEMP_DIR="$DIR/logs/"
# NOTE: if you use /tmp/ all users can read packages you (attempt to) install
#TEMP_DIR="/tmp/"

#function zypper { # used for testing on non-OpenSUSE systems
#  echo "actually zypper ""$@"
#}

# test if "$1" == "in" - if it is continue; otherwise pass everything to zypper
# NOTE: not dealing with installing multple packages
if [[ "$1" != "in" || "$#" != "2" ]]; then
  zypper "$@"
  exit
fi

# lets keep a log of zypper's output
if [ ! -z "$TEMP_DIR" ]; then
  mkdir -p "$TEMP_DIR"
  temp=$(mktemp -p "$TEMP_DIR")
else
  echo "\$TEMPDIR is not set, please fix and try again."
  exit 1
fi

zypper "$@" | tee "$temp"
# if zypper does not exit with 0
if [ " ${PIPESTATUS[0]}" -ne "0" ]; then
  # check output for ...
  #grep "'$2' not found in package names." < "$temp" &> /dev/null
  grep "No provider of '$2' found." < "$temp" &> /dev/null
  if [ "$?" -eq "0" ]; then
    # have zypper search for "$2" in packages
    zypper se "$2"
  fi
fi
