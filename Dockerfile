FROM node:latest as builder
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
RUN yarn install

COPY . /usr/src/app
RUN yarn build

FROM nginx:1-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html