# Build stage
FROM node:18-alpine as builder
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --silent || npm i
COPY . .
RUN npm run build

# Serve stage
FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [\"/usr/sbin/nginx\", \"-g\", \"daemon off;\"]
