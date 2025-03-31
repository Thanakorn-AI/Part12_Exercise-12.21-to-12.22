FROM node:20

WORKDIR /usr/src/app

COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Expose the port Vite development server uses
EXPOSE 5173

# Start the app in development mode
CMD ["npm", "run", "dev", "--", "--host"]