FROM node:18.7.0-alpine
WORKDIR '/app'
COPY package*.json .
RUN npm install
COPY . .
EXPOSE 8000

CMD ["npm", "start"]