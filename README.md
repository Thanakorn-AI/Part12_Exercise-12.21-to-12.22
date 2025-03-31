# Full-Stack Bloglist App (Containerized)

This project is a containerized full-stack application built as part of Exercises 12.21 and 12.22 for the Full Stack Open course. It consists of a React frontend, an Express backend, a MongoDB database, and an Nginx reverse proxy, all orchestrated using Docker Compose. The app allows users to create, view, and manage blogs, with user authentication for secure access.

## Project Structure

```
Part12_Exercise-12.21-to-12.22/
├── bloglist-frontend/          # Frontend (React + Vite)
│   ├── dev.Dockerfile          # Dockerfile for development
│   └── Dockerfile              # Dockerfile for production
├── Fullstack_Part4_backend/    # Backend (Express)
│   ├── dev.Dockerfile          # Dockerfile for development
│   ├── Dockerfile              # Dockerfile for production
│   └── .env                    # Environment variables
├── nginx.dev.conf              # Nginx config for development
├── nginx.conf                  # Nginx config for production
├── docker-compose.dev.yml      # Docker Compose for development
├── docker-compose.yml          # Docker Compose for production
└── README.md                   # This file
```

## Prerequisites

- **Docker**: Ensure Docker and Docker Compose are installed on your machine.
- **Node.js**: Used for local development (optional if running entirely in Docker).
- **Postman** (optional): For testing API endpoints (e.g., creating a user).

## Running the Application

This project supports two environments: **development** and **production**. Each environment is configured using a separate Docker Compose file and can be accessed at different URLs.

### 1. Development Environment (`http://localhost:8080`)

The development environment is designed for local development with features like hot reloading (Vite for the frontend, Nodemon for the backend) and live code updates via Docker volumes.

#### Command to Start
```bash
docker compose -f docker-compose.dev.yml up --build
```

#### What It Does
- Uses `docker-compose.dev.yml` to configure the development setup.
- Builds and starts the services: frontend (React + Vite), backend (Express), mongo (MongoDB), and nginx (reverse proxy).
- Maps port 8080 on your host to port 80 in the nginx container, so the app is accessible at http://localhost:8080.
- Enables hot reloading for the frontend (via Vite on port 5173) and backend (via Nodemon).
- Mounts volumes for live code updates, so changes to the source code are reflected immediately.

#### Command to Stop
```bash
docker compose -f docker-compose.dev.yml down
```

### 2. Production Environment (`http://localhost:80`)

The production environment is optimized for deployment, with static files for the frontend, a production-ready backend, and no development tools.

#### Command to Start
```bash
docker compose -f docker-compose.yml up --build
```

#### What It Does
- Uses `docker-compose.yml` to configure the production setup.
- Builds and starts the services: frontend (static files served by Nginx), backend (Express in production mode), mongo (MongoDB), and nginx (reverse proxy).
- Maps port 80 on your host to port 80 in the nginx container, so the app is accessible at http://localhost:80.
- The frontend is built into static files (via `npm run build`) and served by Nginx.
- The backend runs in production mode (`NODE_ENV=production`) with no hot reloading or development tools.

#### Command to Stop
```bash
docker compose -f docker-compose.yml down
```

## Environment Variables

The backend requires environment variables, defined in `Fullstack_Part4_backend/.env`. For the production environment, ensure the file contains:

```env
MONGODB_URI=mongodb://mongo:27017/Fullstack_part4
PORT=3003
NODE_ENV=production
SECRET=your-secret-key-here
```

- **MONGODB_URI**: Points to the local MongoDB container (mongo service).
- **PORT**: The port the backend runs on (must match the Nginx proxy configuration).
- **NODE_ENV**: Set to production for the production environment.
- **SECRET**: Used for JWT authentication (replace with your own secret key).

For the development environment, you can use MongoDB Atlas if preferred by updating MONGODB_URI to your Atlas connection string.

## Testing the Application

### Development Environment

1. Start the development environment:
   ```bash
   docker compose -f docker-compose.dev.yml up --build
   ```
2. Open http://localhost:8080 in your browser.
3. Log in or create a new user (you may need to use Postman to create a user if using a local MongoDB).
4. Test features like creating blogs, which should persist after refreshing the page.

### Production Environment

1. Start the production environment:
   ```bash
   docker compose -f docker-compose.yml up --build
   ```
2. Open http://localhost:80 in your browser.
3. Create a new user using Postman (since the local MongoDB is empty):
   - Endpoint: `POST http://localhost:80/api/users`
   - Body (JSON):
     ```json
     {
       "username": "testuser",
       "name": "Test User",
       "password": "password123"
     }
     ```
4. Log in with the new credentials at http://localhost:80.
5. Create a blog and refresh the page to confirm it persists.

## Notes

- **Port Conflicts**: If port 80 is in use, the production setup will fail to start. Check for conflicts with:
  ```bash
  lsof -i :80
  ```
  Kill the conflicting process or change the port in `docker-compose.yml` (e.g., `ports: - 8000:80`).
- **MongoDB Persistence**: Data persists across container restarts thanks to the `mongo-data` volume. However, switching between MongoDB Atlas and the local container will require creating new users.

## Exercises

This project fulfills the requirements for:

- **Exercise 12.21**: Containerized development environment (`docker-compose.dev.yml`).
- **Exercise 12.22**: Containerized production environment (`docker-compose.yml`).

Both environments have been tested and confirmed to work, including user creation, login, blog creation, and data persistence.
