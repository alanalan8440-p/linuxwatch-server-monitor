
#!/bin/bash

# ==========================================
# LinuxWatch - Disk Space Monitor
# Purpose: Monitor disk usage and show alerts
# ==========================================

# Set the disk usage thresholds
WARNING_THRESHOLD=80
CRITICAL_THRESHOLD=90

# Select the filesystem to monitor
FILESYSTEM="/"

# Print the report title
echo "========================================"
echo "       LINUXWATCH DISK MONITOR"
echo "========================================"

# Display the filesystem being monitored
echo ""
echo "Filesystem: $FILESYSTEM"

# Get disk usage percentage for the selected filesystem
DISK_USAGE=$(df -P "$FILESYSTEM" | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

# Check whether disk usage was collected successfully
if [[ -z "$DISK_USAGE" ]]; then
    echo "ERROR: Unable to read disk usage."
    exit 1
fi

# Display the current disk usage
echo "Current Disk Usage: ${DISK_USAGE}%"

# Compare disk usage against the thresholds
if (( DISK_USAGE >= CRITICAL_THRESHOLD )); then
    echo "STATUS: CRITICAL - Disk usage is at or above 90%!"
elif (( DISK_USAGE >= WARNING_THRESHOLD )); then
    echo "STATUS: WARNING - Disk usage is at or above 80%."
else
    echo "STATUS: OK - Disk usage is below 80%."
fi

# Display the report generation time
echo ""
echo "Report Generated At: $(date)"

# Finish the report
echo "========================================"

