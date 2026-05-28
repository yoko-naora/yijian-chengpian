#!/bin/bash
# Check dependencies for yijian-chengpian (macOS/Linux)

checks=("ffmpeg:-version" "ffprobe:-version" "node:--version" "python3:--version" "git:--version" "yt-dlp:--version")

echo ""
echo "yijian-chengpian Dependency Check"
echo "================================="
echo ""

missing=0
for entry in "${checks[@]}"; do
    cmd="${entry%%:*}"
    arg="${entry##*:}"
    if command -v "$cmd" &> /dev/null; then
        ver=$($cmd $arg 2>&1 | head -1)
        echo "[OK] $cmd: $ver"
    else
        echo "[!!] $cmd: not found"
        ((missing++))
    fi
done

echo ""
if [ $missing -gt 0 ]; then
    echo "$missing dependency(s) missing."
else
    echo "All dependencies OK."
fi
