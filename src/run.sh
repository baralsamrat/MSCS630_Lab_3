#!/bin/bash
# run.sh
# This script creates a virtual environment (if not present),
# installs dependencies if available,
# and runs a set of experiments for the disk simulator.
#
# Adjust the DISK_PATH variable to point to the location of main.py.
#
# For example:
#   If your structure is:
#       MSCS630_Lab_3/
#           main.py
#           src/run.sh
#   Then, if you want to run from the project root, you can add "cd .."
#   at the top and set: DISK_PATH="main.py"
#
#   If your structure is:
#       MSCS630_Lab_3/
#           src/
#               main.py
#               run.sh
#   Then, set: DISK_PATH="main.py" (or use the current directory).
#
# Alternatively, if you prefer to run from the project root and main.py is in src,
# set: DISK_PATH="src/main.py"

set -e

# ***** Adjust this variable as needed *****
DISK_PATH="main.py"
# ***** End Adjustment Section *****

# Create virtual environment if not exists.
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate the virtual environment.
source venv/bin/activate

# Install dependencies if requirements.txt exists.
if [ -f "requirements.txt" ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
fi

# Define an output file.
OUTPUT_FILE="output.txt"
echo "Running optimized disk simulator experiments..." > "$OUTPUT_FILE"

# Define experiments in an array with a descriptor and the command.
experiments=(
  "FIFO:python3 $DISK_PATH -a 7,30,8 -p FIFO"
  "SSTF:python3 $DISK_PATH -a 7,30,8 -p SSTF"
  "SATF:python3 $DISK_PATH -a 7,30,8 -p SATF"
  "SeekRate (-S 2):python3 $DISK_PATH -a 7,30,8 -S 2"
  "RotationRate (-R 0.1):python3 $DISK_PATH -a 7,30,8 -R 0.1"
)

# Loop through experiments.
for exp in "${experiments[@]}"; do
   IFS=":" read -r desc cmd <<< "$exp"
   echo "----------------------------------------" | tee -a "$OUTPUT_FILE"
   echo "Experiment: $desc" | tee -a "$OUTPUT_FILE"
   echo "Command: $cmd" | tee -a "$OUTPUT_FILE"
   echo "Output:" | tee -a "$OUTPUT_FILE"
   $cmd | tee -a "$OUTPUT_FILE"
   echo "" | tee -a "$OUTPUT_FILE"
done

echo "All optimized experiments completed. Detailed output saved in $OUTPUT_FILE."

# Deactivate the virtual environment.
deactivate
