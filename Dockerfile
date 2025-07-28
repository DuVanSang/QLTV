# Multi-stage build cho ứng dụng full-stack
# Stage 1
FROM node:18-alpine AS frontend-builder

WORKDIR /app/frontend

# Copy package files
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Build frontend
RUN npm run build

# Stage 2
FROM maven:3.8.8-openjdk-17 AS backend-builder

WORKDIR /app/backend

# Copy Maven files
COPY backend/pom.xml ./
COPY backend/mvnw ./
COPY backend/mvnw.cmd ./
COPY backend/.mvn ./.mvn

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY backend/src ./src

# Build backend
RUN ./mvnw clean package -DskipTests

# Stage 3: Production image
FROM openjdk:17-jre-alpine

# Install nginx for serving frontend
RUN apk add --no-cache nginx wget

# Create app directory
WORKDIR /app

# Copy built frontend from stage 1
COPY --from=frontend-builder /app/frontend/dist /var/www/html

# Copy built backend JAR from stage 2
COPY --from=backend-builder /app/backend/target/*.jar app.jar

# Create nginx configuration
RUN echo 'server {\n    listen 80;\n    server_name localhost;\n    root /var/www/html;\n    index index.html;\n    location / {\n        try_files $uri $uri/ /index.html;\n    }\n    location /api {\n        proxy_pass http://localhost:8080;\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n        proxy_set_header X-Forwarded-Proto $scheme;\n    }\n}' > /etc/nginx/http.d/default.conf

# Create startup script
RUN echo '#!/bin/sh\nnginx\njava -jar app.jar' > /app/start.sh && chmod +x /app/start.sh

# Expose ports
EXPOSE 80 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 http://localhost:8080/actuator/health || exit 1

# Start application
CMD ["/app/start.sh"] 