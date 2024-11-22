# XUI.One Docker Installation

A containerized setup for XUI One using Docker.

# The container will:

1. Use Ubuntu 24.04 as base image
2. Install required dependencies
3. Run the XUI One installer automatically
4. Create persistent volumes for MySQL and XUI data

# Configuration

The service exposes the following ports:

Port 80: HTTP
Port 443: HTTPS
Port 3306: MySQL

Data is persisted in two Docker volumes:

xui_mysql: MySQL database files
xui_home: XUI installation files

# Note

1. The container uses a wrapper script to handle first-time

```bash
#!/bin/bash                           # Defines bash shell interpreter
mkdir -p /opt/xui                     # Creates XUI installation directory
chmod 777 /opt/xui                    # Sets full permissions for the directory

# Installation Check and Logic
if [ ! -f "/opt/xui/.installed" ]; then    # Checks if installation flag exists
    echo "Y" | ./install.sh                # Runs installer with auto-yes
    touch /opt/xui/.installed              # Creates installation flag
else
    echo "XUI already installed, starting service..."  # Skip if already installed
fi

tail -f /dev/null                     # Keeps container running
```

2. installation and service startup
3. Installation status is tracked via /opt/xui/.installed flag
4. Services restart automatically unless explicitly stopped
5. check https://github.com/amidevous/xui.one/blob/master/install.python3 .. this file will be used for applying crack.
