#!/bin/bash

if [ "$1" == "" ]; then
  echo "No png files specified"
  exit 1
fi

for src in "$@"; do
  echo "$src"

  src_size=$(identify -format "%[fx:w]x%[fx:h]" "$src") || continue
  RANDOM=$(md5sum "$src" | cut -d' ' -f1)
  noise_seed=$RANDOM
  convert -size "$src_size" xc: -seed "$noise_seed" +noise random tmp.png && mv -f tmp.png "$src"
  [ -f tmp.png ] && rm tmp.png
done

