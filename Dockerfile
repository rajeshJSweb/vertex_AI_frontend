# Step 1: Build the React app with Node.js 20 on Alpine
FROM node:20-alpine as builder
WORKDIR /app
COPY package*.json yarn*.lock ./
RUN yarn install
COPY . .
RUN yarn build
CMD [ "yarn", "start" ]


# Step 2: Serve the React app with Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=builder /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
