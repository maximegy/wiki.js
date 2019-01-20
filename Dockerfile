FROM ubuntu:xenial
MAINTAINER MaximeGY https://github.com/maximegy
COPY /docker-entrypoint.sh /usr/local/bin/
RUN echo "updating system..." \
        && apt update > /dev/null 2>&1 && apt upgrade -y > /dev/null 2>&1 \
    && echo "creating wiki.js folder" \
        && mkdir /opt/wiki.js && cd /opt/wiki.js \
    && echo "changing script properties" \
        && chmod +x /usr/local/bin/docker-entrypoint.sh \
    && echo "installing curl gnupg gnupg2 and git" \
        && apt install curl gnupg gnupg2 git -y > /dev/null 2>&1 \
    && echo "installing nodejs" \
        && curl -sL https://deb.nodesource.com/setup_11.x | bash - > /dev/null 2>&1 \
        && apt-get install -y nodejs > /dev/null 2>&1 \
    && echo "installing mongodb" \
        && apt-get install mongodb -y > /dev/null 2>&1 \
    && echo "removing bad mongodb installation" \
        && apt remove mongodb -y > /dev/null 2>&1 && apt autoremove -y > /dev/null 2>&1 \
    && echo "installing real mongodb" \
        && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 > /dev/null 2>&1 \
        && echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list > /dev/null 2>&1 \
        && apt-get update > /dev/null 2>&1 \
        && apt install -y mongodb-org > /dev/null 2>&1 \
        && service mongodb start \
    && echo "installing wiki.js files" \
        && curl -sSo- https://wiki.js.org/install.sh | bash
EXPOSE 3000
WORKDIR /
CMD bash -C '/usr/local/bin/docker-entrypoint.sh';'bash'