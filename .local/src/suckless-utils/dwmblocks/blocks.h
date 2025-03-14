//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"󰃠 ", "echo $(brillo -G | cut -d'.' -f1)%",	0,		4},
	{"󰕾 ", "echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')%",	1,		5},
	{" ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
	{"󰂄 ", "echo $(cat /sys/class/power_supply/BAT*/capacity)% $(cat /sys/class/power_supply/BAT*/status)",	30,		0},
	{" ", "date +'%b %d (%a) %I:%M %p'",	1,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
