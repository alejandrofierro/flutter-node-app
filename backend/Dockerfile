FROM node:14.15.5-alpine3.13

ENV PORT 5555

WORKDIR /home/app

COPY ./ /home/app

RUN npm install

EXPOSE 5555

CMD ["npm", "run", "start"]