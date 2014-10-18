#!/usr/bin/fish

while true

  set dwm_wifi [(iwgetid -r)]

  if test (cat /sys/class/power_supply/AC/online) = 1
    set dwm_power_status [+]
  else
    set dwm_power_status [(acpi | grep -Eo '(:?[0-9]+){3}' | cut -c 1-5)]
  end

  set dwm_power_percent [(acpi | grep -Eo '[0-9]+%')]

  set dwm_vol (amixer sget Master | awk -vORS=' ' '/Mono:/ {print($6$4)}')

  set dwm_clock (date '+%a %d %b | %R')

  xsetroot -name "$dwm_wifi $dwm_power_status$dwm_power_percent $dwm_vol$dwm_clock"
  sleep 1;
  
end
