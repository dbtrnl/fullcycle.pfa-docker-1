FROM node:15.14.0-alpine3.10
RUN apk add bash
WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json", "index.js", "./"]

CMD ["npm install"]

ENTRYPOINT ["node", "index.js"]