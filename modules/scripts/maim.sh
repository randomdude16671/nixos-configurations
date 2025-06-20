file=~/screenshots/$(date +%s).png
maim -s "$file" && xclip -selection clipboard -t image/png -i "$file" 
ln -sf "$file" ~/screenshots/latest.png
echo "Screenshot, Time '$(date)': '$file'" >> ~/screeshots/log.txt
