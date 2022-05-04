FROM alpine

RUN echo "Update software cache" && \
    apk add --update

RUN echo "Add required softwares" && apk add --no-cache tzdata bash curl

RUN echo "Add MongoDB dependencies" && apk add mongodb-tools

RUN echo "Add AWS client library" && \
    apk add --update py-pip groff less mailcap \
    && pip install awscli

RUN rm /var/cache/apk/*
