#!/bin/sh
set -e
set -x

ver=dev-2025-06
url=https://github.com/odin-lang/Odin/releases/download/$ver/odin-linux-amd64-$ver.zip
zip=odin.zip
dst=odin-bin

mkdir -p $dst
curl -fL $url -o $zip
unzip $zip -d $dst
rm $zip

cd $dst
tar xzf dist.tar.gz
cd -

$dst/odin-linux-amd64-nightly+2025-06-02/odin version
