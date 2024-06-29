# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar power-bar 2>&1 | tee -a /tmp/polybar2.log & disown
polybar date-bar 2>&1 | tee -a /tmp/polybar2.log & disown
polybar music-bar 2>&1 | tee -a /tmp/polybar2.log & disown
polybar workspaces-bar 2>&1 | tee -a /tmp/polybar2.log & disown
polybar sys-bar 2>&1 | tee -a /tmp/polybar2.log & disown
