#!/system/bin/sh

clear

CAM="android.permission.CAMERA"
MIC="android.permission.RECORD_AUDIO"
LOC="android.permission.ACCESS_FINE_LOCATION"

do_cam=1
do_mic=1
do_loc=1
out=0
file="/sdcard/permission_report.txt"

for f in "$@"
do
  case "$f" in
    --camera) do_mic=0; do_loc=0 ;;
    --mic) do_cam=0; do_loc=0 ;;
    --location) do_cam=0; do_mic=0 ;;
    --all) do_cam=1; do_mic=1; do_loc=1 ;;
    --export) out=1 ;;
  esac
done

pkgs=`pm list packages -3 | cut -d: -f2`

cam_list=""
mic_list=""
loc_list=""

Has() {
  pm check-permission "$1" "$2" >/dev/null 2>&1
}

Op() {
  appops get "$1" "$2" 2>/dev/null | grep -E "$2: (allow|foreground)" >/dev/null 2>&1
}

for p in $pkgs
do
  if appops 2>/dev/null | grep -q get; then
    if [ "$do_cam" -eq 1 ] && Has "$p" "$CAM" && Op "$p" "CAMERA"; then
      cam_list="${cam_list}- $p
"
    fi
    if [ "$do_mic" -eq 1 ] && Has "$p" "$MIC" && Op "$p" "RECORD_AUDIO"; then
      mic_list="${mic_list}- $p
"
    fi
    if [ "$do_loc" -eq 1 ] && Has "$p" "$LOC" && Op "$p" "ACCESS_FINE_LOCATION"; then
      loc_list="${loc_list}- $p
"
    fi
  fi
done

txt=""
[ "$do_cam" -eq 1 ] && txt="${txt}📷 CAMERA:
${cam_list}
"
[ "$do_mic" -eq 1 ] && txt="${txt}🎙️ MICROPHONE:
${mic_list}
"
[ "$do_loc" -eq 1 ] && txt="${txt}📍 LOCATION:
${loc_list}
"

if [ "$out" -eq 1 ]; then
  printf "%s" "$txt" > "$file"
  echo "Report exported to $file"
else
  printf "%s" "$txt"
fi