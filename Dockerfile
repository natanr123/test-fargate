FROM node:8-alpine

EXPOSE 8080

COPY . .

CMD [ "node", "app.js" ]

