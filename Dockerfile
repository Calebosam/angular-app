FROM node:18-alpine AS build

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . .

RUN npm run build


FROM  nginx:stable-alpine-slim

COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist/my-app /usr/share/nginx/html

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
