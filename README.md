
# LinuxWatch - Linux Server Monitor

LinuxWatch is a Bash-based Linux monitoring toolkit that helps users
check basic system health, network connectivity, disk usage, log messages,
and service status from a single menu.

## Features

- **System Health Check** - Displays hostname, uptime, CPU load averages,
  memory usage, and root filesystem usage.
- **Network Diagnostics** - Checks network interfaces, default route,
  connectivity, DNS resolution, and HTTPS access.
- **Disk Space Monitor** - Reports root filesystem usage with warning
  and critical thresholds.
- **Log Analyzer** - Counts ERROR, WARNING, and FAILED keywords and
  saves a timestamped report.
- **Service Monitor** - Checks selected systemd services.
- **Main Menu** - Runs individual checks or all checks from one place.

## Project Structure

```text
linuxwatch-server-monitor/
├── main.sh
├── scripts/
│   ├── health_check.sh
│   ├── network_check.sh
│   ├── disk_monitor.sh
│   ├── log_analyzer.sh
│   └── service_monitor.sh
├── tests/
│   └── sample.log
├── reports/
├── config/
├── docs/
├── README.md
└── .gitignore
```

## Requirements

- Linux or a compatible Bash environment
- Bash
- Standard utilities such as `df`, `awk`, `grep`, `free`, and `ip`
- `curl` and `getent` for network checks
- `systemctl` for service monitoring

Some checks depend on the installed utilities and the Linux environment.
Service monitoring may behave differently in WSL or systems that do not
use systemd.

## How to Run

Clone the repository, then enter the project directory:

```bash
cd linuxwatch-server-monitor
```

Run the menu:

```bash
bash main.sh
```

You can also run individual modules:

```bash
bash scripts/health_check.sh
bash scripts/network_check.sh
bash scripts/disk_monitor.sh
bash scripts/log_analyzer.sh
bash scripts/service_monitor.sh
```

Run the log analyzer from the project root so it can find
`tests/sample.log`.

## Disk Usage Thresholds

- Below 80%: OK
- 80% to 89%: WARNING
- 90% or higher: CRITICAL

## Reports

The log analyzer generates timestamped reports in the `reports/` directory.
Generated reports are excluded from version control by `.gitignore`.

## Testing

Check shell syntax:

```bash
for f in main.sh scripts/*.sh; do
    bash -n "$f" || exit 1
done
```

## Limitations

- The disk monitor currently checks the root filesystem only.
- The log analyzer uses the included sample log file by default.
- The service monitor checks a predefined list of services.
- This is a learning and monitoring toolkit, not a replacement for a
  production-grade monitoring and alerting platform.

## Future Improvements

- Configurable service and filesystem lists
- Automated scheduled checks and alert notifications
- More robust error handling and test cases
- Additional monitoring metrics and report formats

