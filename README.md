# Linux Server Performance Statistics Collector

This project provides a Bash script for gathering and displaying comprehensive system performance statistics on Linux-based servers.

The `server-stats.sh` script is designed to offer system administrators and developers a quick and easy way to assess the current state of their Linux server. It automatically installs any missing dependencies and collects key performance metrics, presenting them in a clear, readable format.

Key features of the script include:

- Automatic installation of required system tools
- Display of OS version and system uptime
- CPU usage statistics
- Memory usage breakdown
- Disk usage information
- Top CPU-consuming processes
- Top memory-consuming processes

This tool is particularly useful for quick system health checks, performance monitoring, and troubleshooting on Linux servers.

## Repository Structure

```
.
└── roadmap-projects-server-performance-stats
    ├── README.md
    └── server-stats.sh
```

- `server-stats.sh`: The main script that collects and displays server performance statistics.

## Usage Instructions

### Installation

1. Ensure you have a Linux-based operating system.
2. Clone this repository or download the `server-stats.sh` script.
3. Make the script executable:

   ```bash
   chmod +x server-stats.sh
   ```

### Running the Script

Execute the script with root privileges:

```bash
sudo ./server-stats.sh
```

The script will automatically check for and install any missing dependencies before collecting and displaying the performance statistics.

### Output

The script provides the following information:

1. OS version and system uptime
2. Total CPU usage (percentage of CPU time spent in different states)
3. Total memory usage (total, used, and free memory with percentages)
4. Total disk usage (total, used, and free disk space with percentages)
5. Top 5 processes sorted by CPU usage
6. Top 5 processes sorted by memory usage

### Configuration

The script does not require any configuration. It automatically detects the system's package manager and installs any missing dependencies.

### Troubleshooting

If you encounter any issues:

1. Ensure you have root privileges when running the script.
2. Check if your system's package manager (apt, yum, dnf, or pacman) is functioning correctly.
3. Verify that your system can connect to the internet to download any missing packages.

If you see an error message about a specific command not being found:

1. Try manually installing the missing command using your system's package manager.
2. Check if the package repositories are accessible from your system.

For debugging:

1. Run the script with bash's debug mode:

   ```bash
   sudo bash -x ./server-stats.sh
   ```

2. This will print each command as it's executed, helping identify where any issues occur.

### Performance Considerations

- The script is designed to have minimal impact on system resources.
- It runs quickly and does not perform continuous monitoring.

## Data Flow

The `server-stats.sh` script follows this data flow:

1. Check for required commands and install if missing
2. Collect system information (OS, uptime)
3. Gather CPU usage statistics
4. Collect memory usage data
5. Retrieve disk usage information
6. Identify top CPU-consuming processes
7. Identify top memory-consuming processes
8. Display all collected information

```
[System] -> [Check Dependencies] -> [Install if needed]
                                 -> [Collect Stats] -> [Display Results]
```

**Note:** The script creates a flag file (`/tmp/install_commands_flag`) to avoid unnecessary reinstallation of dependencies on subsequent runs.

 **Note:** This script was tested on the following environments:

- PC
- Kubernetes (k8s) pod
- AWS EC2 instance

All environments were running Ubuntu 22.04.

This project is part of [roadmap.sh](https://roadmap.sh/projects/server-stats) DevOps projects.
