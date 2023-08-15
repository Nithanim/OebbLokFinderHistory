#!/bin/bash
set -e

mkdir -p positions
rm -f positions/*
cd positions


echo "Fetching index..."
curl https://konzern-apps.web.oebb.at/lok/index/ | jq . > index.json


cat index.json | jq -r '.[].unit_number' | sort -u | while read unit_number; do
  sleep 3

  url="https://konzern-apps.web.oebb.at/lok/index/${unit_number}"
  echo "Fetching $unit_number from $url"

  curl "$url" | jq . > "$unit_number.json"
done

