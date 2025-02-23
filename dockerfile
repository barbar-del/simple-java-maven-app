# Use an official OpenJDK 11 runtime as a base image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file (matching my-app*.jar) into the container
COPY my-app*.jar /app/my-app.jar

# Expose the default application port (optional, adjust as needed)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "/app/my-app.jar"]

