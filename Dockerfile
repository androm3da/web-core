
FROM ubuntu
MAINTAINER Brian Cain <brian.cain@gmail.com>

RUN apt-get update
RUN apt-get install -y python \
                       python-dev \
                       python-distribute \
                       python-pip \
                       python-virtualenv \
                       virtualenvwrapper

RUN useradd metadisk
ADD . /home/metadisk/src/web-core
RUN pip install /home/metadisk/src/web-core

VOLUME /home/metadisk/uploads

RUN apt-get install -y nginx \
                       gunicorn 

WORKDIR /home/metadisk/app/web-core
USER metadisk

ENTRYPOINT [ "gunicorn", "-w", "4", "-t", "60", "-b", "127.0.0.1:5000", "webcore.index:app", ]
