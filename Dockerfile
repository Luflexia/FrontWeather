# Stage 1: Build the application
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
COPY vite.config.js ./
COPY . .

RUN npm install
RUN npm run build

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
