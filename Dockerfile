FROM dockerfile/ubuntu
MAINTAINER Yves Serrano <y@yas.ch>

RUN add-apt-repository ppa:pypy/ppa && \
    apt-get update && apt-get install -yq \
        python3.4 python2.7 pypy && \
    cd /tmp/ && curl -O https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz && cd - && \
    tar -C /usr/local -xzf /tmp/go1.4.linux-amd64.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN /bin/echo -e "#!/bin/sh\nexport PATH=$PATH:/usr/local/go/bin" > /etc/profile.d/go.sh
ADD primes.py /root/primes.py
ADD primes.go /root/primes.go
