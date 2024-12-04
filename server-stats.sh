#!/bin/bash

# Define a flag file to check if installation has already occurred
FLAG_FILE="/tmp/install_commands_flag"

# Function to check and install required commands
check_and_install() {
    # List of required commands
    commands=("sysstat" "free" "df" "ps" "awk" "bsdmainutils" "sed")
    
    for cmd in "${commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "$cmd is not installed. Installing..."
            # Determine if we need to use sudo or not
            if [ "$(id -u)" -eq 0 ]; then
                # Running as root, no sudo needed
                install_command="$cmd"
            else
                # Not running as root, use sudo
                install_command="sudo $cmd"
            fi
            
            # Install the command based on the package manager
            if [ -x "$(command -v apt)" ]; then
                apt update && apt install -y "$cmd"
            elif [ -x "$(command -v yum)" ]; then
                yum install -y "$cmd"
            elif [ -x "$(command -v dnf)" ]; then
                dnf install -y "$cmd"
            elif [ -x "$(command -v pacman)" ]; then
                pacman -S --noconfirm "$cmd"
            else
                echo "Package manager not found. Please install $cmd manually."
                exit 1
            fi
        fi
    done
    
    # Create the flag file to indicate installation has been done
    touch "$FLAG_FILE"
}

# Check if the flag file exists; if not, run the installation function
if [ ! -f "$FLAG_FILE" ]; then
    echo "Installing necessary commands..."
    check_and_install
fi


# Display OS version and uptime
echo "------------------------------------------"
# Extract OS name and version from /etc/os-release
OS_NAME=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
echo "OS Version: $OS_NAME"
echo "Uptime: $(uptime -p)"
echo "------------------------------------------"

# Display total CPU usage
echo "Total CPU Usage (Percentage of CPU time spent in different states):"
iostat -c 1 1 | tail -n +3 | grep -v '^$'
echo "------------------------------------------"

# Display total memory usage
free -m | awk 'NR==2 {
    used=$3; 
    total=$2; 
    free=$4; 
    printf "Total Memory: %.0f GB\nUsed Memory: %.0f GB              Free Memory: %.0f GB\nUsed Memory Percentage: %.2f%%  Free Memory Percentage: %.2f%%\n", 
    total/1024, used/1024, free/1024, (used/total)*100, (free/total)*100
}'
echo "------------------------------------------"

# Display total disk usage
df -h --total | awk 'END {
    used=$3; 
    total=$2; 
    free=$4; 
    used_percent=(used/total)*100; 
    free_percent=(free/total)*100; 
    printf "Total Disk Size: %s\nUsed: %s               Free: %s\nUsed Percentage: %.2f%% Free Percentage: %.2f%%\n", 
    total, used, free, used_percent, free_percent
}'
echo "------------------------------------------"

# Display top 5 processes sorted by CPU usage
echo "Top 5 Processes Sorted by CPU Usage:"
ps -eo pid,%cpu,comm --sort=-%cpu | head -n 6 | sed 's/^[ \t]*//' | column -t
echo "------------------------------------------"

# Display top 5 processes sorted by memory usage
echo "Top 5 Processes Sorted by Memory Usage:"
ps -eo pid,%mem,comm --sort=-%mem | head -n 6 | sed 's/^[ \t]*//' | column -t
echo "------------------------------------------"