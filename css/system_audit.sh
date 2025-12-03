#!/bin/bash

echo "======================================================"
echo "          FULL SYSTEM / NETWORK AUDIT REPORT          "
echo "======================================================"
echo "Generated on: $(date)"
echo ""

echo "==================== SERVER INFO ====================="

echo "Server Brand & Model:"
sudo dmidecode -s system-manufacturer
sudo dmidecode -s system-product-name
echo ""

echo "Serial Number / Asset Tag:"
sudo dmidecode -s system-serial-number
echo ""

echo "CPU Information:"
lscpu | grep -E 'Model name|CPU\(s\)|Thread|Core'
echo ""

echo "Clock Speed (MHz):"
lscpu | grep "CPU MHz"
echo ""

echo "Installed RAM:"
free -h
echo ""

echo "Maximum Supported RAM:"
sudo dmidecode -t memory | grep -i "Maximum Capacity"
echo ""

echo "Storage Devices (HDD/SSD):"
lsblk -o NAME,ROTA,TYPE,SIZE,MODEL
echo ""

echo "Total and Free Disk Space:"
df -h
echo ""

echo "RAID Configuration:"
sudo mdadm --detail --scan 2>/dev/null
sudo mdadm --detail /dev/md0 2>/dev/null
echo ""

echo "Operating System:"
lsb_release -a 2>/dev/null
uname -a
echo ""

echo "Network Interfaces:"
lshw -class network 2>/dev/null | grep -E "logical name|product|vendor|capacity|speed"
echo ""

echo "Uptime / Operational Status:"
uptime -p
echo ""

echo "Temperature / Sensors:"
sudo sensors 2>/dev/null
echo ""

echo "================ NETWORK INFORMATION ================="

echo "IP Addresses:"
ip addr show
echo ""

echo "Routing Table:"
ip route
echo ""

echo "Public IP Address:"
curl -s ifconfig.me
echo ""
echo ""

echo "Active Network Connections:"
sudo ss -tulpn
echo ""

echo "================= ROUTER / INTERNET ==================="

echo "Gateway (Router) IP:"
ip route | grep default | awk '{print $3}'
echo ""

GATEWAY=$(ip route | grep default | awk '{print $3}')

echo "Ping Test to Gateway:"
ping -c 4 $GATEWAY
echo ""

echo "Internet Connectivity Check (Ping Google):"
ping -c 4 8.8.8.8
echo ""

echo "================== POWER & ENVIRONMENT ================"
echo "(UPS data will appear only if NUT is installed)"

echo "UPS Status:"
upsc 2>/dev/null
echo ""

echo "======================================================"
echo "                END OF AUDIT REPORT                   "
echo "======================================================"
