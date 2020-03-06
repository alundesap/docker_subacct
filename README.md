# docker_opensuse

```
cd /Users/i830671/git/docker_subacct

docker build -t alunde/subacct:latest .
docker login -u alunde
docker push alunde/subacct:latest


docker run -ti -p 2222:22 alunde/subacct:latest

```
Connect with:
```
ssh -p 2222 root@localhost
```

First deploy:
```
cf push concile_subacct --docker-image alunde/subacct -d conciletime.com -n subacct -u none -k 1G -m 1G --no-start
cf bs concile_subacct SUBACCT_SS
cf start concile_subacct
cf enable-ssh concile_subacct
cf restart concile_subacct
cf ssh concile_subacct
```

Subsequent deploies:
```
cf push concile_subacct --docker-image alunde/subacct -d conciletime.com -n subacct -u none -k 1G -m 1G
cf ssh concile_subacct
```
root@6cdd85b0-26b9-42ed-5275-3301:~# lsof -n -i -P | grep LISTEN
python3     6 root    3u  IPv4 315325015      0t0  TCP *:8080 (LISTEN)
diego-ssh   7 root    3u  IPv4 315301103      0t0  TCP *:2222 (LISTEN)
chromedri  89 root   14u  IPv4 315316622      0t0  TCP 127.0.0.1:9515 (LISTEN)
python3    95 root    3u  IPv4 315325015      0t0  TCP *:8080 (LISTEN)
python3    95 root    4u  IPv4 315325015      0t0  TCP *:8080 (LISTEN)



