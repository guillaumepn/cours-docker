FROM alpine

MAINTAINER toto <toto@web.fr>

RUN apk --update add openssh && \
rm -rf /var/cache/apk/*

#Generate host keys if not exist
RUN if ! ls /etc/ssh/ssh_host_* 1> /dev/null 2>&1; then ssh-keygen -A; fi

RUN sed -i s/#PermitRootLogin.#/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
&& echo "root:esgi" | chpasswd

EXPOSE 22

CMD ["/user/sbin/sshd", "-D", "-e"]
