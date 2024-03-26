FROM node:20-alpine

RUN apk add --no-cache curl jq

WORKDIR /usr/src/app

COPY package*.json .

RUN npm install

COPY . .

EXPOSE 4173

CMD [ "npm", "run", "start" ]