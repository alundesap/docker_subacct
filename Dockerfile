FROM ubuntu:bionic

ENV PATH "${PATH}:/usr/local/bin:/usr/local/sbin"
ENV PORT "8080"

# Install runtime dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends --assume-yes \
        apt-utils \
        ca-certificates \
        bzip2 \
        libfontconfig \
        openssh-server \
        wget \
        curl \
        htop \
        lsof \
        gdebi \
        python3 \
        python3-pip \
        python3-setuptools \
        unzip \
        git \
        vim \
 && mkdir /run/sshd \
 && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
 && echo "root:Nirvana8484" | chpasswd \
# && curl -Lo /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
# Setting up google-chrome-stable (80.0.3987.132-1) // Caching this version on thedrop so that it version compatible with chromedriver
 && curl -Lo /tmp/google-chrome-stable_current_amd64.deb http://thedrop.sap-a-team.com/files/google-chrome-stable_current_amd64.deb \
 && gdebi -n /tmp/google-chrome-stable_current_amd64.deb \
# && dpkg -i /tmp/google-chrome-stable_current_amd64.deb \
# && apt-get -f install \
# See https://chromedriver.chromium.org/downloads
# && wget -N http://chromedriver.storage.googleapis.com/77.0.3865.40/chromedriver_linux64.zip -P ~/ \
# && wget -N http://chromedriver.storage.googleapis.com/80.0.3987.106/chromedriver_linux64.zip -P ~/ \
 && wget -N http://thedrop.sap-a-team.com/files/chromedriver_linux64.zip -P ~/ \
 && unzip ~/chromedriver_linux64.zip -d ~/ \
 && rm ~/chromedriver_linux64.zip \
 && mv -f ~/chromedriver /usr/local/bin/chromedriver \
 && chown root:root /usr/local/bin/chromedriver \
 && chmod 0755 /usr/local/bin/chromedriver \
 && echo "Last command in RUN" \
 && apt-get clean \
# && echo "WGET Master" \
# && wget -N https://github.com/alundesap/module_subacct/archive/master.zip -P ~/ \
# && unzip ~/master.zip -d ~/ \
 && echo "Done!"
RUN echo "Git Clone" \
 && mkdir -p /root/app \
 && /usr/bin/git clone https://github.com/alundesap/module_subacct.git /root/app \
 && echo "export PATH=\$PATH:/usr/local/bin:/usr/local/sbin" >> /root/.bashrc \
 && echo "export PORT=8080" >> /root/.bashrc \
 && echo "Done!"

#The EXPOSE instruction does not actually publish the port. It functions as a type of documentation between the person who builds the image and the person who runs the container, about which ports are intended to be published. To actually publish the port when running the container, use the -p flag on docker run to publish and map one or more ports, or the -P flag to publish all exposed ports and map them to high-order ports.

COPY entrypoint.sh /usr/local/bin/

#EXPOSE 22
EXPOSE 8080

ENTRYPOINT ["entrypoint.sh"]
#CMD ["/bin/bash"]
