# User-Backup-and-Restore-Utility
The "User Backup and Restore Utility" is a Bash script designed to simplify the process of backing up and restoring user-related system files (/etc/passwd and /etc/shadow) on Unix-like systems. This tool provides a straightforward interface for users to perform backup and restoration tasks with ease.
(This script was created on RedHat)

Features:

Backup Functionality: The script allows users to create backups of the system's passwd and shadow files into a single text file. This backup file contains essential user information required for system user management.

Restore Functionality: Users can restore individual users from the backup file to the local system. The script ensures that the restored user's information is unique and not conflicting with existing users on the system.

User-Friendly Interface: The script provides clear instructions and prompts to guide users through the backup and restoration process. It checks for errors such as missing source files, non-existent backup files, and duplicate user entries to ensure smooth operation.

Command-Line Usage: The utility can be invoked from the command line with specific commands and arguments, making it easy to integrate into automated backup and restoration workflows.

Usage:
To use the "User Backup and Restore Utility," users need to provide the appropriate command along with the required argument:

For backup: $ ./script.sh backup <destination>
For restore: $ ./script.sh restore <backup_location>
This utility simplifies user management tasks on Unix-like systems by offering a reliable and efficient method for backing up and restoring user-related information.
