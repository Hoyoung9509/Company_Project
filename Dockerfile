FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY build/libs/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]
