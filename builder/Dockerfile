FROM python:3.8-slim

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN pip install --upgrade pip

WORKDIR /mkdocs

RUN apt-get update; \
    apt-get install -y git; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD requirements.txt /mkdocs/

RUN pip install -r requirements.txt

RUN mkdir -p /mkdocs/site
RUN mkdir -p /mkdocs/source

ADD docker-entrypoint.sh /

WORKDIR /mkdocs/source

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "build" ]

