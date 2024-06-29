from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os
import subprocess

mod = "mod4"
terminal = guess_terminal()

dunst_volume = "dunstify -a \"progressBar\" \"Volume: \" -h int:value:\"`amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1`\""

dunst_mute = "dunstify -a \"progressBar\" \"Volume:\" \"$(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 3 | cut -d ']' -f 1)\""

dunst_mic = "dunstify -a \"progressBar\" \"Microphone: \" \"$(/home/tomi/.local/bin/get_mic_state dunst)\"" 

dunst_brightness = "dunstify -a \"progressBar\" \"Brightness: \" -h int:value:\"`xbacklight -get`\"" 

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

@hook.subscribe.startup
def autostart_always():
    subprocess.Popen("/home/tomi/.config/qtile/autostart_always.sh")

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod, "control"], "i", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control"], "m", lazy.layout.shrink(), desc="Shrink window"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Previous layout"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating mode"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "s", lazy.spawn("maim -s -u | xclip -selection clipboard -t image/png -i", shell=True)),
    
    KeyChord([mod], "x", [
        Key([], "b", lazy.spawn("firefox"), desc="Launch firefox"),
        Key([], "m", lazy.spawn("thunderbird"), desc="Launch thunderbird"),
        Key([], "f", lazy.spawn("thunar"), desc="Launch thunar"),
        Key([], "s", lazy.spawn("spotify"), desc="Launch spotify"),
        Key([], "x", lazy.spawn("rofi -show drun"), desc="Launch rofi selector"),
        Key([], "e", lazy.spawn("emacsclient -nc -s instance1", shell=True), desc="Launch emacs"),
        ],
        name="Launch"
    ),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2% && " + dunst_volume, shell=True)),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2% && " + dunst_volume, shell=True)),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle && " + dunst_mute, shell=True)),

    Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle && " + dunst_mic, shell=True)),

    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 2 && " + dunst_brightness, shell=True)),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 2 && " + dunst_brightness, shell=True)),
    Key([mod, "shift"], "p", lazy.spawn("rofi -show p -modi p:/usr/bin/rofi-power-menu", shell=True)),
]

group_names = [("1", {'layout': 'max', 'label': ''}),
               ("2", {'layout': 'monadtall', 'label': ''}),
               ("3", {'layout': 'monadtall', 'label': ''}),
               ("4", {'layout': 'max', 'label': u"\uF0C5"}),
               ("5", {'label': u"\uF401"}),
               ("6", {'label': u"\uF135"}),
               ("7", {'label': u"\uF1E6"}),
               ("8", {'label': u"\uF471"}),
               ("9", {'layout': 'max', 'label': u"\uE712"}),
               ]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.MonadTall(border_focus="#00C1B4",
                     border_normal="#004742",
                     border_width=1,
                     margin=5),
    layout.Columns(border_focus="#00C1B4",
                   border_normal="#004742",
                   border_width=1,
                   margin=4),
    layout.Max(),
    layout.Stack(num_stacks=2),
    layout.Matrix(),
    layout.MonadWide(border_focus="#00C1B4",
                     border_normal="#004742",
                     border_width=1,
                     margin=5),
]

widget_defaults = dict(
    font="Fira Code SemiBold",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

sep = widget.Sep(
    size_percent=85,
    foreground='555555'
)

def getBatteryInfo(args):
    return subprocess.run("/home/tomi/.local/bin/battery.py " + args,
                          shell=True,
                          capture_output=True,
                          text=True
                          ).stdout

def getVolumeIcon():
    return subprocess.run("/home/tomi/.local/bin/get_volume",
                          shell=True,
                          capture_output=True,
                          text=True
                          ).stdout

def getKeyboardLayout():
    return subprocess.run("/home/tomi/.local/bin/layout",
                          shell=True,
                          capture_output=True,
                          text=True
                          ).stdout

def getMicState(option):
    return subprocess.run("/home/tomi/.local/bin/get_mic_state " + option,
                          shell=True,
                          capture_output=True,
                          text=True
                          ).stdout.strip() + " "

def textBox(text, font="iosevka", fontsize=30, foreground='FFFFFF'):
    return widget.TextBox(text=text,
                          font=font,
                          fontsize=fontsize,
                          foreground=foreground
                          )

spacer = widget.Spacer(length=12)

colors = {
    'purple' : '9A5FEB',
    'green'  : '34FD50',
    'yellow' : 'D1FE49',
    'orange' : 'FBB23F',
    'pink'   : 'FE1F4E',
    'violet' : 'BE0457',
    'blue'   : '6153CC',
    'grey'   : '4C5B5C',
    'lblue'  : '40A4FF',
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    fontsize=30,
                    font="Iosevka Nerd Font Mono",
                    highlight_method="line",
                    highlight_color=['000000', '222222'],
                    active=colors['purple'],
                    this_current_screen_border='9A5FEB',
                    borderwidth=1,
                    disable_drag=True
                ),
                widget.CurrentLayout(),
                widget.Prompt(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Spacer(),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
                widget.Spacer(),
                widget.GenPollText(
                    func=lambda: getMicState("dunst"),
                    fontsize=12,
                    update_interval=1,
                    foreground=colors['lblue']
                ),
                #textBox(
                #    text='',
                #    font="Iosevka Nerd Font Mono",
                #    fontsize=35,
                #    foreground=colors['grey']
                #),
                #widget.GenPollText(
                #    func=lambda: getKeyboardLayout(),
                #    update_interval=1,
                #),
                #spacer,
                #widget.GenPollText(
                #    func=lambda: getBatteryInfo("-i"),
                #    fontsize=23,
                #    font="Iosevka Nerd Font Mono",
                #    update_interval=1,
                #    foreground=colors['orange']
                #),
                textBox(text="BAT", fontsize=14, foreground=colors['orange']),
                widget.GenPollText(
                    func=lambda: getBatteryInfo("-cs"),
                    update_interval=1,
                ),
                spacer,
                #textBox(text='', fontsize=25, foreground=colors['violet']),
                textBox(text='CPU', fontsize=14, foreground=colors['violet']),
                widget.CPU(
                    format="{load_percent}%"
                ),
                spacer,
                #textBox(text='', fontsize=25, foreground=colors['pink'], font="Iosevka NF"),
                textBox(text="MEM", fontsize=14, foreground=colors['pink']),
                widget.Memory(
                    measure_mem='G',
                    format='{MemUsed:.0f}/16{mm}'
                ),
                spacer,
                #widget.GenPollText(
                #    func=lambda: getVolumeIcon(),
                #    font="iosevka",
                #    fontsize=20,
                #    update_interval=1,
                #    foreground=colors['green']
                #),
                textBox(text="VOL", fontsize=14, foreground=colors['green']),
                widget.Volume(
                    device="pulse",
                ),
                spacer,
                #textBox(text='', fontsize=25, foreground=colors['yellow']),
                textBox(text='BRIGHT', fontsize=14, foreground=colors['yellow']),
                widget.Backlight(
                    backlight_name="intel_backlight",
                    step=2,
                    change_command="xbacklight -set {0}",
                ),
                spacer,
                widget.Wlan(
                    interface='wlp0s20f3',
                    format='{essid}',
                    foreground=colors['blue']
                ),
                widget.Wlan(
                    interface='wlp0s20f3',
                    format='{quality}/70',
                    disconnected_message=''
                ),
            ],
            24,
            margin=2,
            border_color="#004742",
            border_width=1,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag(["shift"], "Button1", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
