//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/									/*Update Interval*/	/*Update Signal*/
    {"",    "sb-music", 								1,		5},
	{"",	"sb-volume",								1,		1},
	{"",	"sb-aqi",									1,		2},
	{"",	"sb-timer",									1,		3},
	{"",	"sb-system",								2,		4},
	{"",	"sb-net",									1,		6},
	{"",	"sb-disks",									10,		5},
	{"",	"sb-time",									30,		0},
	// {"",	"musicplaying",								10,		11},
	// {"",	"status-timer",								1,		0},
	// {"", "date '+%b %d (%a) %I:%M%p'",					5,		0},
	// {"",	"sb-nettraf",	1,	16},
	// {"",	"mouse-toggle",									1,		1},
	/* {"",	"sb-iplocate", 0,	27}, */
	// {"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 3;
