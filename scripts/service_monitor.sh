
#!/bin/bash

# ==========================================
# LinuxWatch - Service Monitor
# Purpose: Check selected Linux service status
# ==========================================

# List the services to monitor
SERVICES=("ssh" "cron" "NetworkManager")

# Print the report title
echo "========================================"
echo "      LINUXWATCH SERVICE MONITOR"
echo "========================================"

# Check each service one by one
for SERVICE in "${SERVICES[@]}"; do

    echo ""
    echo "Checking service: $SERVICE"

    # Check whether the service exists
    if ! systemctl cat "$SERVICE" >/dev/null 2>&1; then
        echo "STATUS: NOT FOUND - Service may not be installed."
        continue
    fi

    # Check whether the service is currently active
    if systemctl is-active --quiet "$SERVICE"; then
        echo "STATUS: ACTIVE - Service is running."
    else
        echo "STATUS: NOT ACTIVE - Investigate service status."
        systemctl is-active "$SERVICE" 2>/dev/null
    fi

done

# Display the report generation time
echo ""
echo "Report Generated At: $(date)"

# Finish the report
echo "========================================"
echo "      SERVICE CHECK COMPLETED"
echo "========================================"

