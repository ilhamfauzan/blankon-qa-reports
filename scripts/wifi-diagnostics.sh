#!/usr/bin/env bash

OUT="wifi-report-$(date +%Y%m%d-%H%M%S).txt"

exec > >(tee "$OUT") 2>&1

echo "======================================"
echo "       LINUX WIFI DIAGNOSTIC"
echo "======================================"

echo
echo "### SYSTEM"
uname -a
cat /etc/os-release

echo
echo "### HARDWARE"
lspci -nnk | grep -iA4 -E 'network|wireless'

echo
echo "### USB DEVICES"
lsusb

echo
echo "### WIFI INTERFACE"
iw dev

IFACE=$(iw dev | awk '$1=="Interface"{print $2; exit}')

if [ -n "$IFACE" ]; then
    echo
    echo "### WIFI LINK"
    iw dev "$IFACE" link

    echo
    echo "### WIFI POWER SAVE"
    iw dev "$IFACE" get power_save

    echo
    echo "### WIFI INTERFACE DETAILS"
    ip -s link show "$IFACE"

    echo
    echo "### NETWORK DEVICE DETAILS"
    nmcli device show "$IFACE"
fi

echo
echo "### LOADED WIFI MODULES"
lsmod | grep -E 'mt76|mt7921|mt7902|cfg80211|mac80211'

echo
echo "### FIRMWARE INFORMATION"
sudo dmesg | grep -iE 'mt76|mt7921|mt7902|firmware' | tail -60

echo
echo "### WIFI / BLUETOOTH KERNEL LOGS"
sudo journalctl -k -b --no-pager | grep -iE 'wifi|wlan|bluetooth|mt76|mt7921|mt7902|aspm' | tail -100

echo
echo "### NETWORKMANAGER"
nmcli general status
nmcli device status

echo
echo "### ROUTING"
ip route

echo
echo "### DNS"
resolvectl status 2>/dev/null || cat /etc/resolv.conf

echo
echo "### RFKILL"
rfkill list

echo
echo "======================================"
echo "Report saved: $OUT"
echo "======================================"
