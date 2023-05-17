#!/bin/bash

# Append path to .bashrc
echo "Appending path to .bashrc..."
echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc

if [ $? -eq 0 ]; then
    echo "Path appended successfully."
else
    echo "Failed to append path to .bashrc. Please check permissions."
    exit 1
fi

# Install the python packages
echo "Installing Python packages..."
pip install pyModeS pyrtlsdr

if [ $? -eq 0 ]; then
    echo "Python packages installed successfully."
else
    echo "Failed to install Python packages. Check the error message above."
    exit 1
fi

# Install the library
echo "Installing librtlsdr-dev..."
sudo apt-get install librtlsdr-dev

if [ $? -eq 0 ]; then
    echo "librtlsdr-dev installed successfully."
else
    echo "Failed to install librtlsdr-dev. Check the error message above."
    exit 1
fi

# Add the udev rules
echo "Adding udev rules..."
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="adm", MODE="0666"' | sudo tee /etc/udev/rules.d/20.rtlsdr.rules

if [ $? -eq 0 ]; then
    echo "udev rules added successfully."
else
    echo "Failed to add udev rules. Please check permissions."
    exit 1
fi

echo "Reloading udev rules..."
sudo udevadm control --reload-rules && sudo udevadm trigger

if [ $? -eq 0 ]; then
    echo "udev rules reloaded successfully."
else
    echo "Failed to reload udev rules. Check the error message above."
    exit 1
fi

echo "All steps completed successfully."
exit 0
