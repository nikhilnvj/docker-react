# Multi-step docker build file
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Used by elastic beanstalk to expose the app on port 80 to the world
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html