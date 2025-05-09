# Part12_Exercise-12.21-to-12.22/Fullstack_Part4_backend/dev.Dockerfile
FROM node:20

WORKDIR /usr/src/app

COPY package*.json ./

# Install dependencies
RUN npm install

# Install nodemon for development
RUN npm install -g nodemon

# Copy the rest of the application
COPY . .

# Expose the backend port
EXPOSE 3003

# Start the app in development mode with nodemon
CMD ["nodemon", "index.js"]