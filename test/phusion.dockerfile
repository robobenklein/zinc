FROM phusion/baseimage:0.10.1

RUN install_clean \
 rsync file curl time wget git tmux zsh sudo vim unzip \
 software-properties-common cmake make gcc g++ python python3 gdb

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN install_clean git-lfs

# user setup
ARG luser=robo
ENV LUSER=${luser}

RUN groupadd -r ${LUSER} -g 901
RUN useradd -m -u 901 -r -g 901 -s /usr/bin/zsh ${LUSER}
RUN adduser ${LUSER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

CMD ["/sbin/my_init"]

ARG CACHEBUST=1

USER ${LUSER}
WORKDIR /home/${LUSER}
RUN mkdir -p /home/${LUSER}/code/p10k
COPY --chown=901:901 ./ code/p10k/
WORKDIR /home/${LUSER}
