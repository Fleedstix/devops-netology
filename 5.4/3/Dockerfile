FROM node:16-buster

RUN cd /opt && git clone https://github.com/simplicitesoftware/nodejs-demo.git \
&& cd nodejs-demo && npm install

EXPOSE 3000

WORKDIR /opt/nodejs-demo

CMD ["npm", "start"]