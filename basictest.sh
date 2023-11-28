#!/bin/sh
actual=$(./less --version | head -1)
expected='less 6.* (POSIX regular expressions)'
if echo "$actual" | grep "$expected"; then
  echo 'basic less test passed'
else
  echo 'less failed'
fi
