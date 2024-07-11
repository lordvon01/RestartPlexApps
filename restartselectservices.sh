#!/bin/bash

# Array of services to choose from
services=("radarr" "sonarr" "tautulli" "lidarr" "bazarr" "ombi")

# Function to display menu and restart selected service
select_service() {
    echo "Select a service to restart:"
    echo "-----------------------------"
    for (( i=0; i<${#services[@]}; i++ )); do
        echo "$((i+1))) ${services[i]}"
    done
    echo "0) Exit"

    read -p "Enter your choice: " choice
    case $choice in
        0) echo "Exiting."; exit ;;
        [1-${#services[@]}])
            selected_service="${services[$((choice-1))]}"
            echo "Restarting $selected_service..."
            sudo systemctl restart "$selected_service"
            if [ $? -eq 0 ]; then
                echo "$selected_service restarted successfully."
            else
                echo "Failed to restart $selected_service."
            fi
            ;;
        *) echo "Invalid choice. Please enter a number from 0 to ${#services[@]}."; select_service ;;
    esac
}

# Main program loop
while true; do
    select_service
    echo ""
done
