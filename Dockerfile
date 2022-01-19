# STEP 1: Build
FROM node:12.20.0-alpine as builder
LABEL maintainer="Breeze"

RUN apk add --no-cache python make g++
RUN yarn global add @tarojs/cli@3.3.16
WORKDIR /usr/src/app
COPY . .
RUN yarn
RUN yarn build:h5



# STEP 2: Package
FROM nginx:latest
LABEL maintainer="Breeze"

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;"]