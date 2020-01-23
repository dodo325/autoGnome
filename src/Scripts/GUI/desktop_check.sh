CURRENT_DESKTOP=$(echo "$XDG_CURRENT_DESKTOP" | grep -Eoi 'xfce|kde|gnome|unity')
CURRENT_DESKTOP=$(echo "$CURRENT_DESKTOP" | sed -e 's/\(.*\)/\L\1/')
peints "[GUI] Checking Desktop Environment"
if [ -z "$CURRENT_DESKTOP" ]
then
      peints_err "[fail] Not found GUI"
      exit
else
      peints "[OK] detect $CURRENT_DESKTOP"
fi