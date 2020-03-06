# docker_opensuse

```
cd /Users/i830671/git/docker_headless

docker build -t alunde/headless:latest .
docker login -u alunde
docker push alunde/headless:latest


docker run -ti -p 2222:22 alunde/headless:latest

```
Connect with:
```
ssh -p 2222 root@localhost
```

First deploy:
```
cf push concile_headless --docker-image alunde/headless -d conciletime.com -n headless -u none -k 1G -m 1G --no-start
cf bs concile_headless HEADLESS_SS
cf start concile_headless
cf enable-ssh concile_headless
cf restart concile_headless
cf ssh concile_headless
```

Subsequent deploies:
```
cf push concile_headless --docker-image alunde/headless -d conciletime.com -n headless -u none -k 1G -m 1G
cf ssh concile_headless
```
root@6cdd85b0-26b9-42ed-5275-3301:~# lsof -n -i -P | grep LISTEN
python3     6 root    3u  IPv4 315325015      0t0  TCP *:8080 (LISTEN)
diego-ssh   7 root    3u  IPv4 315301103      0t0  TCP *:2222 (LISTEN)
chromedri  89 root   14u  IPv4 315316622      0t0  TCP 127.0.0.1:9515 (LISTEN)
python3    95 root    3u  IPv4 315325015      0t0  TCP *:8080 (LISTEN)
python3    95 root    4u  IPv4 315325015      0t0  TCP *:8080 (LISTEN)



