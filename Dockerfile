# this is known as multi-step process
# as builder means tag this stage of dockerfile code as "builder"
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# adding another FROM instruction means that the previous stage has ended.
FROM nginx
# this is only for the AWS Elasticbean. As it reads the exposed ports from this
EXPOSE 80
# to copy from a container/stage, use --from "stage_name"
COPY --from=builder /app/build /usr/share/nginx/html