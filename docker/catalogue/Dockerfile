# Use the official Node.js LTS image as a base
FROM node:lts

# Set the working directory in the container
WORKDIR /app
ENV MONGO=true
# Copy package.json and package-lock.json if available
COPY package.json ./
COPY server.js ./

# Install app dependencies
RUN npm install


# Expose the port your app runs on (adjust if needed)
EXPOSE 8080

# Define the command to run your app
CMD ["node", "server.js"]
