FROM node:20 AS build-stage

WORKDIR /usr/src/app

COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the application source
COPY . .

# Set environment variable for production build
ENV VITE_BACKEND_URL=/api

# Build the application
RUN npm run build

# Production stage
FROM nginx:1.25-alpine

# Copy the build directory from the build-stage to nginx
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html

# Use default nginx configuration
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]