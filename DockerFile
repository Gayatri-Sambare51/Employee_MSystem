# First stage: build the application
FROM maven:3.8.4-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# Second stage: create a minimal image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/Employee_System-1.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
