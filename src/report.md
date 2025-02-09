# Disk Simulator Lab Report

## 1. Introduction

This lab investigates disk access performance by using a disk simulator implemented in **main.py**. The simulator computes three key components of disk access time:

- **Seek Time:** The time required for the disk head to move between tracks, which is proportional to the distance between the current and requested tracks.
- **Rotation Wait Time:** The delay incurred waiting for the desired disk sector to rotate under the head.
- **Transfer Time:** A fixed duration required to read or write data once the head is in position.

The lab experiments cover:
1. **Basic Disk Access Time Computation:** Running the simulator with various disk request sets.
2. **Impact of Seek Rate:** Varying the seek rate to observe its effect on overall access time.
3. **Impact of Rotation Rate:** Changing the disk rotation rate and observing its impact.
4. **Disk Scheduling Policies Exploration:** Comparing FIFO, SSTF, and SATF scheduling for the request stream `-a 7,30,8`.

---

## 2. Experiment 1: Basic Disk Access Time Computation

### Objectives
- To compute the seek, rotation, and transfer times for various disk request sets.
- To observe how these components vary with different inputs.

### Commands and Output

1. **Request `-a 0`**  
   **Command:**  
   `python3 main.py -a 0`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 0
     Seek Time:         0.000 sec
     Rotation Wait:     0.000 sec
     Transfer Time:     0.100 sec
     Completion Time:   0.100 sec

   Total time to complete all requests: 0.100 seconds
   ```

2. **Request `-a 6`**  
   **Command:**  
   `python3 main.py -a 6`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 6
     Seek Time:         6.000 sec
     Rotation Wait:     0.617 sec
     Transfer Time:     0.100 sec
     Completion Time:   6.717 sec

   Total time to complete all requests: 6.717 seconds
   ```

3. **Request `-a 30`**  
   **Command:**  
   `python3 main.py -a 30`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 30
     Seek Time:         30.000 sec
     Rotation Wait:     0.083 sec
     Transfer Time:     0.100 sec
     Completion Time:   30.183 sec

   Total time to complete all requests: 30.183 seconds
   ```

4. **Requests `-a 7,30,8`**  
   **Command:**  
   `python3 main.py -a 7,30,8`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         7.000 sec
     Rotation Wait:     0.719 sec
     Transfer Time:     0.100 sec
     Completion Time:   7.819 sec

   Request 2: Track 30
     Seek Time:         23.000 sec
     Rotation Wait:     0.364 sec
     Transfer Time:     0.100 sec
     Completion Time:   31.283 sec

   Request 3: Track 8
     Seek Time:         22.000 sec
     Rotation Wait:     0.739 sec
     Transfer Time:     0.100 sec
     Completion Time:   54.122 sec

   Total time to complete all requests: 54.122 seconds
   ```

5. **Requests `-a 10,11,12,13`**  
   **Command:**  
   `python3 main.py -a 10,11,12,13`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 10
     Seek Time:         10.000 sec
     Rotation Wait:     0.028 sec
     Transfer Time:     0.100 sec
     Completion Time:   10.128 sec

   Request 2: Track 11
     Seek Time:         1.000 sec
     Rotation Wait:     0.103 sec
     Transfer Time:     0.100 sec
     Completion Time:   11.331 sec

   Request 3: Track 12
     Seek Time:         1.000 sec
     Rotation Wait:     0.103 sec
     Transfer Time:     0.100 sec
     Completion Time:   12.533 sec

   Request 4: Track 13
     Seek Time:         1.000 sec
     Rotation Wait:     0.103 sec
     Transfer Time:     0.100 sec
     Completion Time:   13.736 sec

   Total time to complete all requests: 13.736 seconds
   ```

### Observations and Analysis
- **Seek Time:** Increases with the track number (or distance between tracks). For instance, a request for track 30 results in a higher seek time compared to track 6.
- **Rotation Wait Time:** Varies with the disk’s rotational position. For some tracks, the wait time is minimal (e.g., track 30 with 0.083 sec), while for others it is higher.
- **Transfer Time:** Remains constant at 0.100 sec per request.
- **Total Time:** The cumulative time reflects the combination of seek, rotation, and transfer times.

---

## 3. Experiment 2: Impact of Seek Rate

### Objectives
- To analyze how different seek rate parameters affect the total access time.

### Commands and Output

1. **Seek Rate -S 2**  
   **Command:**  
   `python3 main.py -a 7,30,8 -S 2`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         14.000 sec
     Rotation Wait:     0.719 sec
     Transfer Time:     0.100 sec
     Completion Time:   14.819 sec

   Request 2: Track 30
     Seek Time:         46.000 sec
     Rotation Wait:     0.364 sec
     Transfer Time:     0.100 sec
     Completion Time:   61.283 sec

   Request 3: Track 8
     Seek Time:         44.000 sec
     Rotation Wait:     0.739 sec
     Transfer Time:     0.100 sec
     Completion Time:   106.122 sec

   Total time to complete all requests: 106.122 seconds
   ```

2. **Seek Rate -S 8**  
   **Command:**  
   `python3 main.py -a 7,30,8 -S 8`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         56.000 sec
     Rotation Wait:     0.719 sec
     Transfer Time:     0.100 sec
     Completion Time:   56.819 sec

   Request 2: Track 30
     Seek Time:         184.000 sec
     Rotation Wait:     0.364 sec
     Transfer Time:     0.100 sec
     Completion Time:   241.283 sec

   Request 3: Track 8
     Seek Time:         176.000 sec
     Rotation Wait:     0.739 sec
     Transfer Time:     0.100 sec
     Completion Time:   418.122 sec

   Total time to complete all requests: 418.122 seconds
   ```

3. **Seek Rate -S 40**  
   **Command:**  
   `python3 main.py -a 7,30,8 -S 40`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         280.000 sec
     Rotation Wait:     0.719 sec
     Transfer Time:     0.100 sec
     Completion Time:   280.819 sec

   Request 2: Track 30
     Seek Time:         920.000 sec
     Rotation Wait:     0.364 sec
     Transfer Time:     0.100 sec
     Completion Time:   1201.283 sec

   Request 3: Track 8
     Seek Time:         880.000 sec
     Rotation Wait:     0.739 sec
     Transfer Time:     0.100 sec
     Completion Time:   2082.122 sec

   Total time to complete all requests: 2082.122 seconds
   ```

4. **Seek Rate -S 0.1**  
   **Command:**  
   `python3 main.py -a 7,30,8 -S 0.1`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         0.700 sec
     Rotation Wait:     0.019 sec
     Transfer Time:     0.100 sec
     Completion Time:   0.819 sec

   Request 2: Track 30
     Seek Time:         2.300 sec
     Rotation Wait:     0.064 sec
     Transfer Time:     0.100 sec
     Completion Time:   3.283 sec

   Request 3: Track 8
     Seek Time:         2.200 sec
     Rotation Wait:     0.539 sec
     Transfer Time:     0.100 sec
     Completion Time:   6.122 sec

   Total time to complete all requests: 6.122 seconds
   ```

### Observations and Analysis
- **Higher Seek Rates:** (e.g., 40 and 8) lead to a substantial increase in seek time and therefore a dramatic increase in overall access time.
- **Lower Seek Rate:** (e.g., 0.1) results in very low seek times and overall faster access.
- **Trade-offs:**  
  A high seek rate may be used to simulate hardware with slow head movement, but it negatively impacts performance. Conversely, a low seek rate reduces the delay due to head movement.

---

## 4. Experiment 3: Impact of Rotation Rate

### Objectives
- To observe how varying the rotation rate affects the rotation wait time and total access time.

### Commands and Output

1. **Rotation Rate -R 0.1**  
   **Command:**  
   `python3 main.py -a 7,30,8 -R 0.1`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         7.000 sec
     Rotation Wait:     0.194 sec
     Transfer Time:     0.100 sec
     Completion Time:   7.294 sec

   Request 2: Track 30
     Seek Time:         23.000 sec
     Rotation Wait:     0.639 sec
     Transfer Time:     0.100 sec
     Completion Time:   31.033 sec

   Request 3: Track 8
     Seek Time:         22.000 sec
     Rotation Wait:     5.389 sec
     Transfer Time:     0.100 sec
     Completion Time:   58.522 sec

   Total time to complete all requests: 58.522 seconds
   ```

2. **Rotation Rate -R 0.5**  
   **Command:**  
   `python3 main.py -a 7,30,8 -R 0.5`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         7.000 sec
     Rotation Wait:     0.439 sec
     Transfer Time:     0.100 sec
     Completion Time:   7.539 sec

   Request 2: Track 30
     Seek Time:         23.000 sec
     Rotation Wait:     1.728 sec
     Transfer Time:     0.100 sec
     Completion Time:   32.367 sec

   Request 3: Track 8
     Seek Time:         22.000 sec
     Rotation Wait:     1.478 sec
     Transfer Time:     0.100 sec
     Completion Time:   55.944 sec

   Total time to complete all requests: 55.944 seconds
   ```

3. **Rotation Rate -R 0.01**  
   **Command:**  
   `python3 main.py -a 7,30,8 -R 0.01`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         7.000 sec
     Rotation Wait:     64.944 sec
     Transfer Time:     0.100 sec
     Completion Time:   72.044 sec

   Request 2: Track 30
     Seek Time:         23.000 sec
     Rotation Wait:     13.389 sec
     Transfer Time:     0.100 sec
     Completion Time:   108.533 sec

   Request 3: Track 8
     Seek Time:         22.000 sec
     Rotation Wait:     51.889 sec
     Transfer Time:     0.100 sec
     Completion Time:   182.522 sec

   Total time to complete all requests: 182.522 seconds
   ```

### Observations and Analysis
- **Low Rotation Rate (0.01):** Leads to very high rotation wait times, significantly increasing the total access time.
- **High Rotation Rate (0.5):** Reduces rotation wait times and overall access time.
- **Overall Impact:** The rotation rate is critical for performance; a slower disk rotation means the head waits longer for the correct sector.

---

## 5. Experiment 4: Disk Scheduling Policies Exploration

### Objectives
- To analyze and compare the performance of FIFO, SSTF, and SATF scheduling policies using the request stream `-a 7,30,8`.

### Commands and Output

1. **FIFO Scheduling**  
   **Command:**  
   `python3 main.py -a 7,30,8 -p FIFO`

   **Output:**
   ```
   Disk Scheduling Policy: FIFO
   -------------------------------------------------
   Request 1: Track 7
     Seek Time:         7.000 sec
     Rotation Wait:     0.719 sec
     Transfer Time:     0.100 sec
     Completion Time:   7.819 sec

   Request 2: Track 30
     Seek Time:         23.000 sec
     Rotation Wait:     0.364 sec
     Transfer Time:     0.100 sec
     Completion Time:   31.283 sec

   Request 3: Track 8
     Seek Time:         22.000 sec
     Rotation Wait:     0.739 sec
     Transfer Time:     0.100 sec
     Completion Time:   54.122 sec

   Total time to complete all requests: 54.122 seconds
   ```

2. **SSTF Scheduling**  
   **Command:**  
   `python3 main.py -a 7,30,8 -p SSTF`

   **Output:**
   ```
   Disk Scheduling Policy: SSTF
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

3. **SATF Scheduling**  
   **Command:**  
   `python3 main.py -a 7,30,8 -p SATF`

   **Output:**
   ```
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

### Observations and Analysis
- **FIFO:** Processes requests in the order received, resulting in non-optimal head movements and the longest total time (54.122 sec).
- **SSTF:** Chooses the next request based on the shortest seek time, reducing head movement and achieving a total time of 31.383 sec.
- **SATF:** Also achieves a total time of 31.383 sec in this simulation. Although it considers both seek and rotation wait times, for this particular workload the benefits over SSTF were negligible because the rotational delays were relatively low compared to the seek times.

### Comparison and Analysis of Scheduling Policies
- **FIFO vs. SSTF/SATF:**  
  FIFO does not optimize the request order, leading to longer total access times. SSTF and SATF optimize the order to minimize head movement (and in SATF’s case, also consider rotation wait), leading to improved performance.
- **SSTF vs. SATF:**  
  In this simulation, SATF does not show a significant improvement over SSTF because the rotation wait times are small relative to seek times. However, in environments where the disk’s rotation rate is lower (resulting in higher rotation wait times) or when the distribution of data causes larger rotation delays, SATF is expected to outperform SSTF by further minimizing overall access time.

---

## 6. Conclusions

- **Disk Access Components:**  
  - **Seek Time:** Depends on the difference between successive track requests.
  - **Rotation Wait Time:** Depends on the disk’s rotation speed and the angular positioning of the requested sectors.
  - **Transfer Time:** Is constant in our simulation.
  
- **Impact of Parameters:**  
  - Increasing the seek rate significantly increases total access time.
  - Lower rotation rates (i.e., slower disks) dramatically increase rotation wait times and overall access time.

- **Scheduling Policies:**  
  - FIFO is the simplest policy but often leads to longer access times.
  - SSTF minimizes head movement, reducing overall time.
  - SATF further optimizes by considering rotation delay; its benefits become more pronounced when rotational delays are significant relative to seek times.

- **Overall Analysis:**  
  In our simulated workload (`-a 7,30,8`), SSTF and SATF yielded similar performance. SATF has the potential to outperform SSTF in systems with greater rotational delays, such as when disks have slower rotation speeds or when the target sectors are widely distributed in terms of angular position.

---

## 7. Appendices

### Log Output Screenshot/Excerpt
*(Include screenshots or attach the `output.txt` file generated by the run.sh script. The excerpt above shows the key portions of the output.)*

### References
- **Operating Systems: Three Easy Pieces (OSTEP)**
- Course lecture notes and lab instructions
