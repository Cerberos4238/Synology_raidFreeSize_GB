#!/bin/bash

# --- CONFIGURATION ---
COMMUNITY="MADSI"
HOST="192.168.100.240"
OID=".1.3.6.1.4.1.6574.3.1.1.4"

echo "Free space per volume in GB:"
echo "-----------------------------"

#SNMPWALK
snmpwalk -v2c -c "$COMMUNITY" "$HOST" "$OID" 2</dev/null | while read -r line; do
	#Extract values in bytes
	bytes=$(echo "$line" | awk '{print $NF}')
	#Convert bytes to GB
	gb=$(awk -v b="$bytes" 'BEGIN { printf "%.2f", b / (1024^3) }')
	#OID extraction
	index=$(echo "$line" | awk -F '.' '{print $NF}')
	echo "Volume $index: $gb GB free"
done
