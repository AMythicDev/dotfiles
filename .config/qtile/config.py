import os
import subprocess as sb

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy

home_dir = os.path.expanduser("~")

from typing import List  # noqa: F401

mod = "mod4"
term = "kitty"
config = f"{home_dir}/.config/qtile/config.py"

keys = [
    # Switch between windows in current layout
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # Bindings for resizing windows
    Key([mod, "shift"], "k", lazy.layout.grow_down()),
    Key([mod, "shift"], "j", lazy.layout.grow_up()),
    Key([mod, "shift"], "h", lazy.layout.grow_left()),
    Key([mod, "shift"], "l", lazy.layout.grow_right()),
    Key([mod], "n", lazy.layout.normalize()),

    # Launch termite
    Key([mod], "Return", lazy.spawn(term)),
    # Toggle between different layouts with space
    # Kill Window
    Key([mod], "space", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),

    # Restart and shutdown qtie
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    # Rofi
    Key([mod], "r", lazy.spawn(f"rofi -show drun -show-icons")),
    # MPD
    Key([mod, "control"], "p", lazy.spawn("mpc toggle")),
    Key([mod, "control"], "s", lazy.spawn("mpc stop")),
    Key([mod, "control"], "i", lazy.spawn("mpc volume +5")),
    Key([mod, "control"], "d", lazy.spawn("mpc volume -5")),
    Key([mod, "control"], "n", lazy.spawn("mpc next")),
    Key([mod, "control", "shift"], "p", lazy.spawn("mpc prev")),

    # Make window fullscreen
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen()),

    # Shortcuts for opening programs
    Key([mod, "shift"], "b", lazy.spawn("brave-browser-nightly")),
    Key([mod, "shift"], "f", lazy.spawn("firefox")),
]

groups = [Group(i, layout="bsp") for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.Bsp(border_width=0, margin=5),
    layout.Max(),
    layout.Floating(),
]

widget_defaults = dict(
    font='Droid Sans Bold',
    fontsize=10,
    padding=5,
)
extension_defaults = widget_defaults.copy()

# Autostart
@hook.subscribe.startup_once
def start_once():
    sb.call([f"{home_dir}/.config/qtile/autostart_once"])

@hook.subscribe.startup
def start():
    sb.call([f"{home_dir}/.config/qtile/autostart"])


COLORS = ["#ee4fa8", # Primary Color
          "#001443", # Secondary Color
          "#222222", # Bar Color
        ]

screens = [
    Screen(
        top=bar.Bar(
            [
        widget.GroupBox(this_current_screen_border=COLORS[0],
            highlight_method="block", active="#FFFFFF", inactive="#9c9d9e"),
		widget.TaskList(border=COLORS[0], highlight_method="block"),
                widget.Systray(),
		widget.PulseVolume(background=COLORS[1], padding=10),
		widget.CheckUpdates(colour_have_updates="ff0000", colour_no_updates="0000ff",
                    background=COLORS[0], padding=10),
        widget.Clock(format='%I:%M %p', background=COLORS[1], padding=10),
        widget.Mpd2(background=COLORS[0], status_format="MPD: {play_status}"),
        ],
        20,
	    background=COLORS[2]),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "Qtile"
