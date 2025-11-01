# Use an official Node.js image
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application files
COPY . .

# Expose port (adjust if your app uses a different one)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
