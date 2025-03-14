/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 8;        /* gaps between windows */
static const unsigned int snap      = 28;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMonoNerdFont:size=11" };
static const char dmenufont[]       = "JetBrainsMonoNerdFont:size=11";
static const char col_gray1[]       = "#2a3132";
static const char col_teal[]       = "#66a5ad";
static const char col_snow[]       = "#eDf4f2";
static const char col_charcoal[]        = "#101820";

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_teal, col_gray1, col_charcoal },
	[SchemeSel]  = { col_snow, col_charcoal,  col_snow },
};

/* tagging */
static const char *tags[] = { "", "", "", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,        0,            1,           0 },
	{ "Alacritty",     NULL,       NULL,        1 << 0,            0,           0 },
	{ "firefox",  NULL,       NULL,       1 << 1,       0,           0 },
	{ "Zathura",  NULL,       NULL,       1 << 2,       0,           0 },
	{ "Zotero",     NULL,       NULL,        1 << 2,            0,           0 },
	{ "Cherrytree",  NULL,       NULL,       1 << 2,       0,           0 },
	{ "PacketTracer",  NULL,       NULL,       0,        1,           0 },
	{ "Virt-manager",  NULL,       NULL,       0,        1,           0 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define LAUNCHKEY Mod1Mask|ShiftMask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_teal, "-sb", col_charcoal, "-sf", col_snow, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

/*brightness controls */
static const char *brightnessUp[] = { "sh", "-c", "brillo -A 3 -q && kill -38 $(pidof dwmblocks)", NULL};
static const char *brightnessDown[] = { "sh", "-c", "brillo -U 3 -q && kill -38 $(pidof dwmblocks)", NULL};

/* volume controls */
static const char *volUp[] = {"sh", "-c", "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ && kill -39 $(pidof dwmblocks)", NULL};
static const char *volDown[] = {"sh", "-c", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && kill -39 $(pidof dwmblocks)", NULL};
static const char *volMuteToggle[] = {"sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", NULL};

/* screenshot */
static const char *screenShot[] = {"sh", "-c", "Pic=${HOME}/Pictures/Screenshots/$(date +%s).png;scrot -f -s $Pic && xclip -sel clip -t image/png -i $Pic && notify-send 'Copied image to clipboard'", NULL};

/* music */
static const char *toggleMusicPlayPause[] = {"sh", "-c", "mpc toggle", NULL};
static const char *nextMusic[] = {"sh", "-c", "mpc next", NULL};
static const char *prevMusic[] = {"sh", "-c", "mpc prev", NULL};

/* wallpaper */ 
static const char *changeWallpaper[] = {"ch-wallp", NULL};

/* launch browser */
static const char *browser[] = {"firefox", NULL};

/* launch file manager */
static const char *fileManager[] = {"alacritty","-e","lf", NULL};

/* keys */
static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },

  /* Brightness Keys */
	{ 0,             XF86XK_MonBrightnessUp,      spawn,           {.v = brightnessUp } },
	{ 0,             XF86XK_MonBrightnessDown,      spawn,           {.v = brightnessDown } },

  /* Volume Keys */
	{ 0,             XF86XK_AudioRaiseVolume,      spawn,           {.v = volUp } },
	{ 0,             XF86XK_AudioLowerVolume,      spawn,           {.v = volDown } },
	{ 0,             XF86XK_AudioMute,      spawn,           {.v = volMuteToggle } },

  /* Screenshot */
	{ 0,             XK_Print,      spawn,           {.v = screenShot } },

  /* Music Keys */
	{ MODKEY|ShiftMask,            XK_m,      spawn,           {.v = toggleMusicPlayPause } },
	{ MODKEY|ShiftMask,            XK_n,      spawn,           {.v = nextMusic } },
	{ MODKEY|ShiftMask,            XK_b,      spawn,           {.v = prevMusic } },

  /* Change Wallpaper Key */
	{ LAUNCHKEY,            XK_b,      spawn,           {.v = changeWallpaper } },

  /* Open browser Key */
	{ LAUNCHKEY,            XK_w,      spawn,           {.v = browser } },

  /* Open file manager Key */
	{ LAUNCHKEY,            XK_f,      spawn,           {.v = fileManager } },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

