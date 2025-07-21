#!/usr/bin/env sh

data=$(curl -L https://gitlab.com/api/v4/projects/48404603/releases/permalink/latest)

# name=$(echo $data | jq '.tag_name' | sed 's/"//g')
link_tar=$(echo $data | jq '.assets.links[] | select(.name | test(".tar.xz$")) | .url' | sed 's/"//g')
link_sha=$(echo $data | jq '.assets.links[] | select(.name | test(".tar.xz.sha256sum$")) | .url' | sed 's/"//g')

shasum=$(curl $link_sha | cut -d " " -f 1)

sed -i "s|\"url\": \".*pipeline.*\"|\"url\": \"$link_tar\"|" de.schmidhuberj.tubefeeder.json
sed -i "s|\"sha256\": \".*\"|\"sha256\": \"$shasum\"|" de.schmidhuberj.tubefeeder.json
