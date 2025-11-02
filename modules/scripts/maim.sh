file=$HOME/screenshots/$(date +%s).png
grim -g "$(slurp)" "$file" &&
    wl-copy --type image/png <"$file" &&
    ln -sf "$file" $HOME/screenshots/latest.png &&
    echo "Screenshot, Time '$(date)': '$file'" >>$HOME/screenshots/log.txt
