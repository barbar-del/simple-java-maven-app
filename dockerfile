# Step 1: Use a Maven image to build the application
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# version arg default 0
ARG VERSION_NUM=0

WORKDIR /app

COPY pom.xml .
COPY src ./src

# Use Maven to package the application with the version number
RUN mvn clean package -Drevision=${VERSION_NUM}

# Step 2: copy to a new container and use it to minimize the size
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

ARG VERSION_NUM=0

# Copy the built JAR with the specified version
COPY --from=builder /app/target/my-app-1.0.${VERSION_NUM}.jar app.1.0.${VERSION_NUM}.jar

# Run the application using the specified JAR file
CMD ["sh", "-c", "java -jar app.1.0.${VERSION_NUM}.jar"]

