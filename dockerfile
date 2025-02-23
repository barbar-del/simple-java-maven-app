# Step 1: Use a Maven image to build the application
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Step 2: Use a lightweight JRE image to run the application
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/my-app-1.0-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]

