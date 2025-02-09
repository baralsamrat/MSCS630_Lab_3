#!/usr/bin/env python3
"""
Disk Simulator (main.py)
This simulator computes disk access times for a series of track requests.
It simulates:
  - Seek time: proportional to the absolute difference between the current track and the requested track.
  - Rotation wait time: based on a continuously rotating disk.
  - Transfer time: a fixed cost per request.
It also supports three scheduling policies:
  - FIFO: processes requests in the order given.
  - SSTF: chooses the request with the smallest seek distance.
  - SATF: chooses the request with the smallest overall access time (seek + rotation wait + transfer).
  
Usage examples:
    python3 main.py -a 7,30,8
    python3 main.py -a 7,30,8 -S 2
    python3 main.py -a 7,30,8 -R 0.1
    python3 main.py -a 7,30,8 -p SSTF
    python3 main.py -a 7,30,8 -p SATF
"""

import argparse

def parse_requests(requests_str):
    """Parse comma-separated track numbers."""
    return [int(r.strip()) for r in requests_str.split(',') if r.strip()]

def compute_rotation_wait(current_angle, target_angle, angular_speed):
    """
    Compute the wait time for the disk to rotate from the current angle
    to the target angle.
    """
    if target_angle >= current_angle:
        return (target_angle - current_angle) / angular_speed
    else:
        return (360 - current_angle + target_angle) / angular_speed

def simulate_requests(requests, seek_rate, rotation_rate, policy, transfer_time):
    """
    Simulate processing the disk requests.
    
    Each request is associated with a sector angle computed as:
         (track_number * 37) % 360
    (This arbitrary mapping simulates that data is located at different positions
    on the disk platter.)
    
    The simulation keeps track of:
      - current_track: the current head position (starting at track 0)
      - current_time: the total elapsed time
      - current_angle: the current angular position of the disk (in degrees)
    
    The disk rotates continuously at a rate of `rotation_rate` revolutions per second.
    Therefore, the angular speed is:
         angular_speed = 360 * rotation_rate   (degrees per second)
    """
    current_track = 0
    current_time = 0.0
    current_angle = 0.0  # in degrees
    angular_speed = 360 * rotation_rate  # degrees per second

    schedule_order = []  # to store details of each request's processing

    # Create a list of pending requests as tuples: (track, sector_angle)
    pending = [(req, (req * 37) % 360) for req in requests]

    while pending:
        # Select next request based on the chosen scheduling policy.
        if policy == "FIFO":
            # Process in the order provided.
            req = pending.pop(0)
        elif policy == "SSTF":
            # Choose the request with the smallest seek distance.
            req = min(pending, key=lambda x: abs(x[0] - current_track))
            pending.remove(req)
        elif policy == "SATF":
            # Choose the request with the smallest total cost (seek + rotation wait + transfer).
            def total_cost(request):
                track, target_angle = request
                seek_cost = abs(track - current_track) * seek_rate
                # Simulate time passing during the seek.
                new_time = current_time + seek_cost
                new_angle = (current_angle + angular_speed * seek_cost) % 360
                rotation_wait = compute_rotation_wait(new_angle, target_angle, angular_speed)
                return seek_cost + rotation_wait + transfer_time
            req = min(pending, key=total_cost)
            pending.remove(req)
        else:
            raise ValueError("Unknown scheduling policy: " + policy)

        track, target_angle = req

        # Compute seek time.
        seek_time = abs(track - current_track) * seek_rate
        # Update time and current angle during the seek.
        current_time += seek_time
        current_angle = (current_angle + angular_speed * seek_time) % 360

        # Compute rotation wait time.
        rotation_wait = compute_rotation_wait(current_angle, target_angle, angular_speed)
        current_time += rotation_wait
        # Assume the head waits until the desired sector aligns.
        current_angle = target_angle

        # Add transfer time.
        current_time += transfer_time

        # Record details for this request.
        schedule_order.append({
            "track": track,
            "seek_time": seek_time,
            "rotation_wait": rotation_wait,
            "transfer_time": transfer_time,
            "completion_time": current_time
        })

        # Update the current track position.
        current_track = track

    return schedule_order

def main():
    parser = argparse.ArgumentParser(description="Disk Simulator (main.py)")
    parser.add_argument("-a", "--access", required=True,
                        help="Comma-separated list of disk track requests (e.g., 7,30,8)")
    parser.add_argument("-S", "--seek_rate", type=float, default=1.0,
                        help="Seek rate (time per track); default is 1.0")
    parser.add_argument("-R", "--rotation_rate", type=float, default=1.0,
                        help="Rotation rate (revolutions per second); default is 1.0")
    parser.add_argument("-p", "--policy", choices=["FIFO", "SSTF", "SATF"], default="FIFO",
                        help="Disk scheduling policy (FIFO, SSTF, or SATF); default is FIFO")
    args = parser.parse_args()

    requests = parse_requests(args.access)
    transfer_time = 0.1  # Fixed transfer time for each request (in seconds)

    schedule = simulate_requests(requests, args.seek_rate, args.rotation_rate, args.policy, transfer_time)
    total_time = schedule[-1]["completion_time"] if schedule else 0

    # Print detailed results.
    print("Disk Scheduling Policy:", args.policy)
    print("-------------------------------------------------")
    for idx, entry in enumerate(schedule):
        print(f"Request {idx+1}: Track {entry['track']}")
        print(f"  Seek Time:         {entry['seek_time']:.3f} sec")
        print(f"  Rotation Wait:     {entry['rotation_wait']:.3f} sec")
        print(f"  Transfer Time:     {entry['transfer_time']:.3f} sec")
        print(f"  Completion Time:   {entry['completion_time']:.3f} sec")
        print("")
    print(f"Total time to complete all requests: {total_time:.3f} seconds")

if __name__ == "__main__":
    main()
