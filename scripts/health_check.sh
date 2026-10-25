
#!/bin/bash

# ==========================================
# LinuxWatch - Linux Server Health Monitor
# Purpose: Check basic Linux server health
# ==========================================

# Show the report title
echo "========================================"
echo "       LINUXWATCH HEALTH REPORT"
echo "========================================"

# Show the system hostname
echo ""
echo "[1] HOSTNAME"
hostname

# Show how long the system has been running
echo ""
echo "[2] SYSTEM UPTIME"
uptime

# Show CPU load averages
echo ""
echo "[3] CPU LOAD"
cat /proc/loadavg

# Show RAM and memory usage
echo ""
echo "[4] MEMORY USAGE"
free -h

# Show disk space for the root filesystem
echo ""
echo "[5] DISK USAGE"
df -h /

# Show the current date and time
echo ""
echo "[6] REPORT GENERATED AT"
date

# Finish the report
echo ""
echo "========================================"
echo "       HEALTH CHECK COMPLETED"
echo "========================================"

