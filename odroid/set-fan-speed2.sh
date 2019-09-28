#!/bin/bash

echo '1 10 50 95' > /sys/devices/odroid_fan.14/fan_speeds
echo '50 70 80' > /sys/devices/odroid_fan.14/temp_levels

