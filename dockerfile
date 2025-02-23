# Step 1: Use a Maven image to build the application
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Accept version number as a build argument
ARG VERSION_NUM=0

WORKDIR /app

COPY pom.xml .
COPY src ./src

# Use Maven to package the application with the version number
RUN mvn clean package -Drevision=1.0.${VERSION_NUM}
RUN ls target && echo "@@@@@@@@@@@@@@@@@@@@@@@@"
# Step 2: Use a lightweight JRE image to run the application
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Accept the same build argument in the runtime stage
ARG VERSION_NUM=0

# Copy the built JAR with the specified version
COPY --from=builder /app/target/my-app-1.0.${VERSION_NUM}.jar app.1.0.${VERSION_NUM}.jar

# Run the application using the specified JAR file
CMD ["sh", "-c", "java -jar app.1.0.${VERSION_NUM}.jar"]

