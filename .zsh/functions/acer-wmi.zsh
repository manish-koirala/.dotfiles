# A simple script to toggle battery conservation mode in acer laptops.
# Install acer
# https://github.com/Diman119/acer-wmi-battery.git
acer-toggle-battery-conservation-mode () {
  if [[ $(lsmod | grep 'acer_wmi_battery' ) != "" ]] ; then
    if [[ $(cat /sys/bus/wmi/drivers/acer-wmi-battery/health_mode) == "1" ]] ; then
      echo 0 | sudo tee /sys/bus/wmi/drivers/acer-wmi-battery/health_mode
      notify-send "Battery Conservation Mode disabled."
    else
      echo 1 | sudo tee /sys/bus/wmi/drivers/acer-wmi-battery/health_mode
      notify-send "Battery Conservation Mode enabled."
    fi
  fi
}
