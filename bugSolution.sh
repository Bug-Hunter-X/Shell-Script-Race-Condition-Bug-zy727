#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file safely using flock
write_to_file() {
  local file=$1
  local message=$2
  flock -x "$file" || exit 1
  echo "$message" >> "$file"
  flock -u "$file"
}

# Start two processes simultaneously
(while true; do write_to_file file1.txt "Process 1: ""`date +%s`"; sleep 1; done) &
(while true; do write_to_file file2.txt "Process 2: ""`date +%s`"; sleep 1; done) &

# Wait for a short period
sleep 5

# Stop the processes and examine the files
kill %1
kill %2

# Check if file content is correctly written or not

cat file1.txt
cat file2.txt