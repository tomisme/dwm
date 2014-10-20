#!/usr/bin/fish

set _notified_low_power 0
set _suspended 0

while true

  set _wifi [(iwgetid -r)]
  set _power (acpi | grep -Eo '[0-9]{1,2}%' | grep -Eo '[0-9]{1,2}') 
  set _power_percent [(acpi | grep -Eo '[0-9]+%')]
  set _vol (amixer sget Master | awk -vORS=' ' '/Mono:/ {print($6$4)}')
  set _clock (date '+%a %d %b | %R')

  if test (cat /sys/class/power_supply/AC/online) = 1
    set _power_charging [+]
  else
    set _power_charging [(acpi | grep -Eo '(:?[0-9]+){3}' | cut -c 1-5)]
  end

  xsetroot -name "$_wifi $_power_charging$_power_percent $_vol$_clock"

  if math "$_power < 25" > /dev/null
    if math "$_notified_low_power == 0" > /dev/null
      set _notified_low_power 1
      notify-send -u critical "Low Battery (25%)"
    end
  else
    set _notified_low_power 0
  end

  if math "$_power < 10" > /dev/null
    if math "$_suspended == 0" > /dev/null
      set _suspended 1
      systemctl suspend
    end
  else
    set _suspended 0
  end

  sleep 1;
end
