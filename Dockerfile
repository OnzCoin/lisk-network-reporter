FROM node:8.1.2
RUN apt-get update
RUN apt-get install sudo
RUN git clone hhttps://github.com/OnzCoin/onz-network-reporter/
ADD ./postinstall.sh /
RUN chmod +x /postinstall.sh
ENTRYPOINT /postinstall.sh
WORKDIR /onz-network-reporter
