# A simple script to toggle battery conservation mode in lenovo laptops.
lenovo-toggle-battery-conservation-mode () {
  if [[ $(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode) == "1" ]] ; then
    echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
    notify-send "Battery Conservation Mode disabled."
  else
    echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
    notify-send "Battery Conservation Mode enabled."
  fi
}
