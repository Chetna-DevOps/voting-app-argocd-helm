FROM node:18-slim

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV PORT=90
EXPOSE 90

CMD ["node", "server.js"]
