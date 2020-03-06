#!/bin/bash

pip3 install wheel

# generate host keys if not present
ssh-keygen -A

# check wether a random root-password is provided
if [ ! -z "${ROOT_PASSWORD}" ] && [ "${ROOT_PASSWORD}" != "root" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

/usr/bin/git -C /root/app pull
pip3 install -r /root/app/requirements.txt

exec /usr/local/bin/chromedriver --disable-dev-shm-usage &>/dev/null &

# Run the main server python script
exec env PORT=8080 python3 /root/app/server.py

# do not detach (-D), log to stderr (-e), passthrough other arguments
#exec /usr/sbin/sshd -D -e "$@"

