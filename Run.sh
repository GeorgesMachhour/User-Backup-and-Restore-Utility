#!/bin/bash

echo "This tool is created by Georges MACHHOUR"

echo "---------------------------------------------------------"

# Backup function
backup() {
  # Check if the destination directory exists
  if [ ! -d "$1" ]; then
    echo "Error: Destination directory does not exist. Please create a new one, or choose an existing one"
    return 1
  fi

  # Check if the source files exist
  if [ ! -f "/etc/passwd" ] || [ ! -f "/etc/shadow" ]; then
    echo "Error: Source files do not exist."
    return 1
  fi

  # Create a single backup file by launchig cat command on the contents of passwd and shadow and saving them in a file text
sudo cat /etc/passwd /etc/shadow > "$1/backup_file.txt"
  echo "Backup finished successfully."
}

# Restore function
restore() {
  # Check if the backup file exists
  if [ ! -f "$1/backup_file.txt" ]; then
    echo "Error: Backup file doesn't exist."
    return 1
  fi

  # Display the list of users in the backup file
  echo "List of users in the backup:"
  grep -E "^[^:]+" "$1/backup_file.txt"
# ^[^:]+ - This part of the expression matches one or more characters that are not a colon (:), at the beginning of a line (indicated by the ^ character).
# : - This part of the expression matches a single colon character.	..


  # Prompt the user to enter a username to restore
  read -p "Enter the username to restore: " username

  # Check if the user exists in the backup file
  if ! grep -q "^$username" "$1/backup_file.txt"; then
    echo "Error: User does not exist in the backup."
    return 1
  fi

  # Check if the user already exists in the local passwd and shadow files
  if grep -q "^$username" "/etc/passwd" || grep -q "^$username" "/etc/shadow"; then
    echo "Error: This user already exists in the local system."
    return 1
  fi

  # Extract the user's information from the backup file
  user_info=$(grep "^$username" "$1/backup_file.txt")

  # Change the user's ID to a unique value
  user_id=$(grep "^$username" "$1/backup_file.txt" | cut -d ':' -f 3)
  user_id=$((user_id + 1000))
  user_info=$(echo "$user_info" | sed "s/:[^:]*:/:$user_id:/")

  # Append the user's information to the local passwd and shadow files
  echo "$user_info" >> "/etc/passwd"
  echo "$user_info" >> "/etc/shadow"
  echo "Restore successful."
}

# Check if the required number of arguments is provided
if [ $# -ne 2 ]; then
  echo "How to use it: $0 <command> <argumnet>"
  echo "Commands: -backup <destination>
          -restore <backup_location>"
  exit 1
fi

# Execute the specified command
case "$1" in
  "backup")
    backup "$2"
    ;;
  "restore")
    restore "$2"
    ;;
  *)
    echo "Error: Invalid command."
    exit 1
    ;;
esac
