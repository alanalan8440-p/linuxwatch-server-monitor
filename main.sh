
#!/bin/bash

# ==========================================
# LinuxWatch - Linux Server Monitor
# Purpose: Run monitoring scripts from one menu
# ==========================================

# Find the project directory automatically
PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$PROJECT_DIR/scripts"

# Display the main menu
show_menu() {
    clear
    echo "========================================"
    echo "       LINUXWATCH SERVER MONITOR"
    echo "========================================"
    echo ""
    echo "1. System Health Check"
    echo "2. Network Check"
    echo "3. Disk Space Monitor"
    echo "4. Log Analyzer"
    echo "5. Service Monitor"
    echo "6. Run All Checks"
    echo "0. Exit"
    echo ""
}

# Run one monitoring script
run_script() {
    local script_name="$1"
    local script_path="$SCRIPTS_DIR/$script_name"

    echo ""
    if [[ -f "$script_path" && -r "$script_path" ]]; then
        bash "$script_path"
    else
        echo "ERROR: Script not found or unreadable: $script_name"
    fi

    echo ""
    read -r -p "Press Enter to return to the menu..."
}

# Main menu loop
while true; do
    show_menu
    read -r -p "Enter your choice: " choice

    case "$choice" in
        1) run_script "health_check.sh" ;;
        2) run_script "network_check.sh" ;;
        3) run_script "disk_monitor.sh" ;;
        4) run_script "log_analyzer.sh" ;;
        5) run_script "service_monitor.sh" ;;
        6)
            for script in \
                health_check.sh \
                network_check.sh \
                disk_monitor.sh \
                log_analyzer.sh \
                service_monitor.sh
            do
                echo ""
                echo "Running: $script"
                echo "----------------------------------------"
                bash "$SCRIPTS_DIR/$script"
                echo ""
            done
            read -r -p "All checks finished. Press Enter to return..."
            ;;
        0)
            echo "Exiting LinuxWatch. Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice. Please enter 0-6."
            read -r -p "Press Enter to try again..."
            ;;
    esac
done

