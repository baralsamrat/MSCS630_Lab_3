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


## 4. Experiments
 #### Output File: [output.txt](./src/output.txt)

## 5. Observations
 #### Report File: [report.md](./src/report.md)


## 6. Conclusion
- Optimal scheduling improves disk performance.
- Seek and rotation rates significantly impact access times.




