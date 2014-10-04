#!/usr/bin/fish

while true

  # set dwm_wifi (cat /proc/net/wireless) | awk something??
  set dwm_wifi [(iwgetid -r)]

  if test (cat /sys/class/power_supply/AC/online) = 1
    set dwm_power_symbol [+]
    set dwm_power_time ''
  else
    set dwm_power_symbol [-]
    set dwm_power_time [(acpi | grep -Eo '(:?[0-9]+){3}' | cut -c 1-5)]
  end

  set dwm_power_percent [(acpi | grep -Eo '[0-9]+%')]

  set dwm_vol (amixer sget Master | awk -vORS=' ' '/Mono:/ {print($6$4)}')

  set dwm_clock (date '+%a %d %b | %R')

  xsetroot -name "WiFi: $dwm_wifi | Power: $dwm_power_symbol$dwm_power_percent$dwm_power_time | Vol: $dwm_vol| $dwm_clock"
  sleep 1;
  
end
