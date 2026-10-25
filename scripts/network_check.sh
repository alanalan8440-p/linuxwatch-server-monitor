
#!/bin/bash
# ==========================================
# LinuxWatch - Network Diagnostics
# Purpose: Check basic network connectivity
# ==========================================

# Define test targets
TEST_IP="1.1.1.1"
TEST_HOST="example.com"
TEST_URL="https://example.com"

# Print the report title
echo "========================================"
echo "       LINUXWATCH NETWORK CHECK"
echo "========================================"

# Check whether required commands are available
for CMD in ip ping getent curl; do
    if ! command -v "$CMD" >/dev/null 2>&1; then
        echo "ERROR: Required command '$CMD' is missing."
        exit 1
    fi
done

# Check network interfaces
echo ""
echo "[1] NETWORK INTERFACES"
if ip addr show; then
    echo "Interface check completed."
else
    echo "WARNING: Could not read network interfaces."
fi

# Check the default route
echo ""
echo "[2] DEFAULT ROUTE"

DEFAULT_ROUTE=$(ip route show default)

if [[ -n "$DEFAULT_ROUTE" ]]; then
    echo "$DEFAULT_ROUTE"
    echo "PASS: Default route is configured."
else
    echo "WARNING: No default route found."
fi

# Test connectivity to an external IP address
echo ""
echo "[3] INTERNET CONNECTIVITY"
if ping -c 2 -W 3 "$TEST_IP" >/dev/null 2>&1; then
    echo "PASS: $TEST_IP responded to ping."
else
    echo "WARNING: Ping failed for $TEST_IP."
    echo "ICMP may be blocked, so verify using other checks."
fi

# Check whether DNS can resolve the hostname
echo ""
echo "[4] DNS RESOLUTION"
if getent hosts "$TEST_HOST"; then
    echo "PASS: DNS resolution succeeded for $TEST_HOST."
else
    echo "WARNING: Could not resolve $TEST_HOST."
fi

# Check HTTPS connectivity
echo ""
echo "[5] HTTPS CONNECTIVITY"
HTTP_CODE=$(curl -L -sS -o /dev/null \
    --connect-timeout 5 --max-time 10 \
    -w "%{http_code}" "$TEST_URL" 2>/dev/null)
CURL_RESULT=$?

if [[ "$CURL_RESULT" -eq 0 ]] && [[ "$HTTP_CODE" =~ ^[0-9]{3}$ ]] && [[ "$HTTP_CODE" != "000" ]]; then
    echo "PASS: HTTPS request completed. HTTP status: $HTTP_CODE"
else
    echo "WARNING: HTTPS request failed or timed out."
fi

# Display the report generation time
echo ""
echo "Report Generated At: $(date)"

# Finish the report
echo "========================================"
echo "       NETWORK CHECK COMPLETED"
echo "========================================"

