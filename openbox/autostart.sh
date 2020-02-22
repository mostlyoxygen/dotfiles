compton --backend glx --vsync drm -c -r 4 -l -5 -t -5 -o .5 &
/usr/lib/gnome-settings-daemon/gsd-xsettings &
tint2 -c ~/dotfiles/tint2/gust.tint2rc &
feh --bg-fill $(find ~/wallpapers -type f | shuf | head -n 1) &
