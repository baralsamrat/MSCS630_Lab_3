# Disk Simulator MSCS630_Lab_3

Disk Scheduling and Performance Exploration Using the Disk Simulator


## 1. Introduction
This lab explores disk access time: seek time, rotation wait time, and transfer time.
We analyze the effects of different scheduling policies: FIFO, SSTF, and SATF.

## 2. Implementation Details
The simulator processes track requests and computes seek, rotation, and transfer times.
It supports scheduling policies to optimize disk access.

Disk Simulator
This simulator computes disk access times for a series of track requests.

It simulates:
  - Seek time: proportional to the absolute difference between the current track and the requested track.
  - Rotation wait time: based on a continuously rotating disk.
  - Transfer time: a fixed cost per request.\

It also supports three scheduling policies:
  - FIFO: processes requests in the order given.
  - SSTF: chooses the request with the smallest seek distance.
  - SATF: chooses the request with the smallest overall access time (seek + rotation wait + transfer).

```bash
Usage examples:
    python3 disk.py -a 7,30,8
    python3 disk.py -a 7,30,8 -S 2
    python3 disk.py -a 7,30,8 -R 0.1
    python3 disk.py -a 7,30,8 -p SSTF
    python3 disk.py -a 7,30,8 -p SATF
```

## 3. Run The Program
 - Implement Virtual Environement
 - Run the Asignment FIFO, SSTF, and SATF.
 - Give Result in Output File & Terminal

```bash
chmod +x run.sh     
 ./run.sh 
```

![1](/screenshots/1.png)
![2](/screenshots/2.png)


## 4. Output
 #### Output File: [output.txt](./src/output.txt)

  ```bash
Running disk simulator experiments for lab tasks...
----------------------------------------
Experiment: Access Time: Request -a 0
Command: python3 main.py -a 0
Output:
Disk Scheduling Policy: FIFO
-------------------------------------------------
Request 1: Track 0
  Seek Time:         0.000 sec
  Rotation Wait:     0.000 sec
  Transfer Time:     0.100 sec
  Completion Time:   0.100 sec

Total time to complete all requests: 0.100 seconds

----------------------------------------
.
.
. (for more : src/output.txt)
.
.
----------------------------------------
Experiment: SATF Scheduling
Command: python3 main.py -a 7,30,8 -p SATF
Output:
Disk Scheduling Policy: SATF
-------------------------------------------------
Request 1: Track 7
  Seek Time:         7.000 sec
  Rotation Wait:     0.719 sec
  Transfer Time:     0.100 sec
  Completion Time:   7.819 sec

Request 2: Track 8
  Seek Time:         1.000 sec
  Rotation Wait:     0.103 sec
  Transfer Time:     0.100 sec
  Completion Time:   9.022 sec

Request 3: Track 30
  Seek Time:         22.000 sec
  Rotation Wait:     0.261 sec
  Transfer Time:     0.100 sec
  Completion Time:   31.383 sec

Total time to complete all requests: 31.383 seconds

  ```


## 5. Experiments and Observations
 #### Report File: [report.md](./src/report.md)
- **Seek Rate**: Higher values increase seek time.
- **Rotation Rate**: Higher values decrease rotational latency.
- **Scheduling**:
  - FIFO: Processes requests in order.
  - SSTF: Minimizes seek distance.
  - SATF: Minimizes total access time.


## 6. Conclusion
- Optimal scheduling improves disk performance.
- Seek and rotation rates significantly impact access times.




