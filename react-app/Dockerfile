# Use Node.js image for building the React app
FROM node:18-alpine as build

# Set working directory in the container
WORKDIR /app

# Copy all files from the current directory to the container
COPY . .

# Install dependencies and build the project
RUN npm install && npm run build

# Serve the app with Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

