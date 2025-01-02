#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Start two processes simultaneously
(while true; do echo $$ >> file1.txt; sleep 1; done) & 
(while true; do echo $$ >> file2.txt; sleep 1; done) & 

# Wait for a short period
sleep 5

# Stop the processes and examine the files
kill %1
kill %2

# Check if file content is correctly written or not

cat file1.txt
cat file2.txt