#!/run/current-system/sw/bin/bash

DEVICE="kbd_backlight"
MAX_BRIGHTNESS=$(brightnessctl -d "$DEVICE" get max)
LEVELS=(0 85 170 255)

CURRENT=$(brightnessctl -d "$DEVICE" get)
CURRENT_PERCENT=$(( (CURRENT * 100) / MAX_BRIGHTNESS + 50 ))

for i in "${!LEVELS[@]}"; do
    THRESHOLD=$(( (LEVELS[$i] * 100) / MAX_BRIGHTNESS + 50 ))
    if [[ $CURRENT_PERCENT -lt $THRESHOLD ]]; then
        break
    fi
    CURRENT_INDEX=$i
done

if [[ "$1" == "reverse" ]]; then
    if [[ $CURRENT_INDEX -eq 0 ]]; then
        NEW_INDEX=$((${#LEVELS[@]} - 1))
    else
        NEW_INDEX=$((CURRENT_INDEX - 1))
    fi
else
    NEW_INDEX=$(((CURRENT_INDEX + 1) % ${#LEVELS[@]}))
fi

brightnessctl set "${LEVELS[$NEW_INDEX]}" -d "$DEVICE"
