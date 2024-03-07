#!/bin/bash

set -e
set -u

echo "Login to Docker Hub"

docker login -u $DOCKER_USER -p $DOCKER_PWD

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

echo "Comparing v2ray versions"
v2rayot=$(curl --silent "https://api.github.com/repos/v2fly/v2ray-core/tags" | jq -r '.[0].name')
v2rayct=$(cat version/v2ray)
if [[ $v2rayot =~ ^v ]]; then
  v2rayot=${v2rayot#v}
fi
echo "V2ray current version:${v2rayct}  Online version:${v2rayot}"
# 判断版本号是否相同 如果相同就exit
if [[ "$v2rayot" != "$v2rayct" ]]; then
  docker build --build-arg="V2RAY_TAG=${v2rayot}" -f Dockerfile.v2ray -t zhiqiangwang/tunnel:v2ray .
  docker push zhiqiangwang/tunnel:v2ray
  echo "$v2rayot" > version/v2ray
  git add version/v2ray
  git commit -a -m "Auto Update v2ray to tag: ${v2rayot}"
fi

echo "Comparing xray versions"
xrayot=$(curl --silent "https://api.github.com/repos/XTLS/Xray-core/tags" | jq -r '.[0].name')
xrayct=$(cat version/xray)
if [[ $xrayot =~ ^v ]]; then
  xrayot=${xrayot#v}
fi
echo "xray current version:${xrayct}  Online version:${xrayot}"
# 判断版本号是否相同 如果相同就exit
if [[ "$xrayot" != "$xrayct" ]]; then
   docker build --build-arg="XRAY_TAG=${xrayot}" -f Dockerfile.xray -t zhiqiangwang/tunnel:xray .
   docker push zhiqiangwang/tunnel:xray
   echo "$xrayot" > version/xray
   git add version/xray
   git commit -a -m "Auto Update xray to tag: ${xrayot}"
fi

git push origin main