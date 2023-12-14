#!/bin/sh
actual=$(./less --version | head -1)
expected='less [6-9][0-9][0-9]x\? (POSIX regular expressions)'
if echo "$actual" | grep -E "$expected"; then
  echo 'basic less test passed'
else
  echo 'less failed'
fi
