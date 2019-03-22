FROM mono:5.18

ENV VERSION=0.2.0.1293
ENV URL=https://github.com/Radarr/Radarr/releases/download/v0.2.0.1293/Radarr.develop.${VERSION}.linux.tar.gz

RUN apt-get -qy update && apt-get -qy install curl libmediainfo0v5 \
  && curl -Lsf "$URL" | tar -C /opt -xzf - \
  && find /opt/Radarr/ -type f -exec chmod +r {} \;

RUN useradd user && install -d -o user -g user /data
USER user
VOLUME /data

EXPOSE 8989
ENTRYPOINT [ "mono", "/opt/Radarr/Radarr.exe", "--data=/data/" ]
