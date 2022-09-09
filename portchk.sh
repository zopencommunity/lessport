#!/bin/sh
#
# Really simple check - make sure output log has the right line
#
dir="$1"
pfx="$2"
chk="$1/$2_check.log"

grep 'All tests passed' "${chk}"
