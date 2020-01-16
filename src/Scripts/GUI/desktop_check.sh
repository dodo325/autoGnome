CURRENT_DESKTOP=$(echo "$XDG_CURRENT_DESKTOP" | grep -Eoi 'xfce|kde|gnome')
CURRENT_DESKTOP=$(echo "$CURRENT_DESKTOP" | sed -e 's/\(.*\)/\L\1/')

echo "[GUI] Checking Desktop Environment"
if [ -z "$CURRENT_DESKTOP" ]
then
      echo "[fail] Not found GUI"
      exit
else
      echo "[OK] detect $CURRENT_DESKTOP"
fi