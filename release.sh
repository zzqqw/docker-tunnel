#!/bin/bash

set -e
set -u

echo "Login to Docker Hub"

docker login -u $DOCKER_USER -p $DOCKER_PWD

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

echo "Comparing v2ray versions"
v2rayov=$(curl --silent "https://api.github.com/repos/v2fly/v2ray-core/tags" | jq -r '.[0].name')
v2raycv=$(cat version/v2ray)
if [[ $v2rayov =~ ^v ]]; then
  v2rayov=${v2rayov#v}
fi
echo "V2ray current version:${v2raycv}  Online version:${v2rayov}"
# 判断版本号是否相同 如果相同就exit
if [[ "$v2rayov" != "$v2raycv" ]]; then
   docker build --build-arg="V2RAY_TAG=${v2rayov}" -f Dockerfile.v2ray -t zhiqiangwang/tunnel:v2ray .
   docker push zhiqiangwang/tunnel:v2ray
   echo "$v2rayov" > version/v2ray
   git add version/v2ray
   git commit -a -m "Auto Update v2ray to buildid: ${v2rayov}"
fi

git push origin main