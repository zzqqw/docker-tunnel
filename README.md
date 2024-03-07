## SSH隧道

~~~
//构建镜像
docker build -f Dockerfile.ssh -t zhiqiangwang/tunnel:ssh . 
//本地运行
docker run -it --name ubuntu-ssh -p 8022:22 -e SSH_USER=ubuntu -e SSH_PASSWORD=123456 -d zhiqiangwang/tunnel:ssh
//创建k8s deployment
kubectl apply -f  https://raw.githubusercontent.com/zzqqw/docker-tunnel/main/deployment-ssh.yaml
~~~

## v2ray隧道

~~~
//构建镜像
docker build --build-arg="V2RAY_TAG=5.14.1" -f Dockerfile.v2ray -t zhiqiangwang/tunnel:v2ray . 
//本地运行（默认配置）
docker run -it --name v2ray -p 10086:10086 -e V2RAY_VMESS_PORT=10086 -e V2RAY_CLIENT_ID=b831381d-6324-4d53-ad4f-8cda48b30811 -d zhiqiangwang/tunnel:v2ray
//本地运行（自定义配置文件）
docker run -it --name v2ray -p 10086:10086 -v /your path/config.json:/etc/v2ray/config.json -d zhiqiangwang/tunnel:v2ray
//创建k8s deployment
kubectl apply -f  https://raw.githubusercontent.com/zzqqw/docker-tunnel/main/deployment-v2ray.yaml
~~~

