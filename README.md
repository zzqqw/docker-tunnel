## SSH隧道

~~~
docker build -f Dockerfile.ssh -t zhiqiangwang/tunnel:ssh . 
docker run -it --name ubuntu-ssh --rm -p 8022:22 zhiqiangwang/tunnel:ssh
kubectl apply -f  https://raw.githubusercontent.com/zzqqw/docker-tunnel/main/deployment-ssh.yaml
~~~

## v2ray

~~~
docker build --build-arg="V2RAY_TAG=5.14.1" -f Dockerfile.v2ray -t zhiqiangwang/tunnel:v2ray . 
docker run -it --name v2ray --rm -p 10086:10086 zhiqiangwang/tunnel:v2ray
kubectl apply -f  https://raw.githubusercontent.com/zzqqw/docker-tunnel/main/deployment-v2ray.yaml
~~~

