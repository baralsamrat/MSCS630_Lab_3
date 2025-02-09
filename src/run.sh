#!/bin/bash
# run.sh
# This script sets up the virtual environment, installs dependencies,
# and runs a series of experiments for the disk simulator (main.py)
# according to the lab tasks.
#
# We use "###" as a delimiter between the experiment description and the command.
#
# Since run.sh and main.py are in the same folder (SRC), we set:
DISK_PATH="main.py"
#
# (If run.sh is in the project root and main.py is in SRC, then use:
# DISK_PATH="SRC/main.py")

# Create virtual environment if it does not exist.
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

# Define the output file (placed in the current directory).
OUTPUT_FILE="output.txt"
echo "Running disk simulator experiments for lab tasks..." > "$OUTPUT_FILE"

# Define experiments for all lab tasks.
# Format for each element: "Description###command"
experiments=(
  # Part 1: Basic Disk Access Time Computation
  "Access Time: Request -a 0###python3 $DISK_PATH -a 0"
  "Access Time: Request -a 6###python3 $DISK_PATH -a 6"
  "Access Time: Request -a 30###python3 $DISK_PATH -a 30"
  "Access Time: Requests -a 7,30,8###python3 $DISK_PATH -a 7,30,8"
  "Access Time: Requests -a 10,11,12,13###python3 $DISK_PATH -a 10,11,12,13"
  
  # Part 1: Impact of Seek Rate
  "Seek Rate (-S 2)###python3 $DISK_PATH -a 7,30,8 -S 2"
  "Seek Rate (-S 8)###python3 $DISK_PATH -a 7,30,8 -S 8"
  "Seek Rate (-S 40)###python3 $DISK_PATH -a 7,30,8 -S 40"
  "Seek Rate (-S 0.1)###python3 $DISK_PATH -a 7,30,8 -S 0.1"
  
  # Part 1: Impact of Rotation Rate
  "Rotation Rate (-R 0.1)###python3 $DISK_PATH -a 7,30,8 -R 0.1"
  "Rotation Rate (-R 0.5)###python3 $DISK_PATH -a 7,30,8 -R 0.5"
  "Rotation Rate (-R 0.01)###python3 $DISK_PATH -a 7,30,8 -R 0.01"
  
  # Part 2: Disk Scheduling Policies Exploration
  "FIFO Scheduling###python3 $DISK_PATH -a 7,30,8 -p FIFO"
  "SSTF Scheduling###python3 $DISK_PATH -a 7,30,8 -p SSTF"
  "SATF Scheduling###python3 $DISK_PATH -a 7,30,8 -p SATF"
)

# Loop through each experiment.
for exp in "${experiments[@]}"; do
    # Split using parameter expansion:
    #  - ${exp%%###*} extracts everything before the first "###"
    #  - ${exp#*###} extracts everything after the first "###"
    desc="${exp%%###*}"
    cmd="${exp#*###}"
    
    echo "----------------------------------------" | tee -a "$OUTPUT_FILE"
    echo "Experiment: $desc" | tee -a "$OUTPUT_FILE"
    echo "Command: $cmd" | tee -a "$OUTPUT_FILE"
    echo "Output:" | tee -a "$OUTPUT_FILE"
    
    # Run the command and capture both stdout and stderr.
    eval "$cmd" 2>&1 | tee -a "$OUTPUT_FILE"
    
    echo "" | tee -a "$OUTPUT_FILE"
done

echo "All experiments completed. Detailed output saved in $OUTPUT_FILE."

# Deactivate the virtual environment.
deactivate
