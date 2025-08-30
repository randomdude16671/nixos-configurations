# replace/add the files you need to remove
set -e

rm '/home/ghost/.librewolf/ghost/search.json.mozlz4.hmBak'
sudo nixos-rebuild switch
