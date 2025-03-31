# Part12_Exercise-12.21-to-12.22/Fullstack_Part4_backend/Dockerfile
FROM node:20-alpine

WORKDIR /usr/src/app

COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production

# Copy the application
COPY . .

# Set environment variables
ENV NODE_ENV=production

# Expose the port
EXPOSE 3003

# Start the application in production mode
CMD ["node", "index.js"]