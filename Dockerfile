# Use official Node.js image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first (for efficient caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source code
COPY . .

# Expose port (adjust if your app runs elsewhere)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
