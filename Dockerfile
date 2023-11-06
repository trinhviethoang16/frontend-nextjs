FROM node:18-alpine

WORKDIR /user/src

COPY package.json ./

RUN echo "fetch-retry-maxtimeout=60000" >> ~/.npmrc
RUN echo "registry=https://registry.yarnpkg.com" >> ~/.npmrc
RUN npm install

COPY . .

RUN npm run build

CMD ["npm", "run", "dev"]