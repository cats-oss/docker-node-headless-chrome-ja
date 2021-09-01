FROM node:13.4.0

# @see https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md
RUN apt-get update -y
RUN apt-get install -y gconf-service \
      libasound2 \
      libatk1.0-0 \
      libc6 \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libexpat1 \
      libfontconfig1 \
      libgcc1 \
      libgconf-2-4 \
      libgdk-pixbuf2.0-0 \
      libglib2.0-0 \
      libgtk-3-0 \
      libnspr4 \
      libpango-1.0-0 \
      libpangocairo-1.0-0 \
      libstdc++6 \
      libx11-6 \
      libx11-xcb1 \
      libxcb1 \
      libxcomposite1 \
      libxcursor1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxi6 \
      libxrandr2 \
      libxrender1 \
      libxss1 \
      libxtst6 \
      ca-certificates \
      fonts-liberation \
      libappindicator1 \
      libnss3 \
      lsb-release \
      xdg-utils \
      unzip \
      fontconfig \
      wget

# Japanese font
RUN mkdir -p /tmp \
      && cd /tmp \
      && wget https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
      && mkdir -p /usr/share/fonts/NotoSansCJKjp \
      && unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
      && rm NotoSansCJKjp-hinted.zip \
      && fc-cache -fv \
