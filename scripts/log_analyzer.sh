
#!/bin/bash

# ==========================================
# LinuxWatch - Log Analyzer
# Purpose: Find and count important log messages
# ==========================================

# Select the log file to analyze
LOG_FILE="tests/sample.log"

# Create a timestamp for the report filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Define the report output file
REPORT_FILE="reports/log_report_${TIMESTAMP}.txt"

# Check whether the log file exists and is readable
if [[ ! -f "$LOG_FILE" || ! -r "$LOG_FILE" ]]; then
    echo "ERROR: Log file does not exist or cannot be read."
    echo "File: $LOG_FILE"
    exit 1
fi

# Create the reports directory if needed
mkdir -p reports

# Start the report
{
    echo "========================================"
    echo "       LINUXWATCH LOG ANALYZER"
    echo "========================================"
    echo "Log File: $LOG_FILE"
    echo "Analyzed At: $(date)"
    echo ""

    # Count ERROR messages
    ERROR_COUNT=$(grep -Eic 'ERROR' "$LOG_FILE")
    echo "ERROR count: $ERROR_COUNT"

    # Count WARNING messages
    WARNING_COUNT=$(grep -Eic 'WARNING' "$LOG_FILE")
    echo "WARNING count: $WARNING_COUNT"

    # Count FAILED messages
    FAILED_COUNT=$(grep -Eic 'FAILED' "$LOG_FILE")
    echo "FAILED count: $FAILED_COUNT"

    echo ""
    echo "MATCHING LOG ENTRIES"
    echo "----------------------------------------"

    # Show lines containing important keywords
    grep -Ein 'ERROR|WARNING|FAILED' "$LOG_FILE" || true

    echo "----------------------------------------"
    echo "       ANALYSIS COMPLETED"
    echo "========================================"

} > "$REPORT_FILE"

# Display the report location
echo "Log analysis completed."
echo "Report saved to: $REPORT_FILE"

# Display the report in the terminal
echo ""
cat "$REPORT_FILE"

