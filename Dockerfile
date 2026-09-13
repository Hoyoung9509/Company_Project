FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY build/libs/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dfile.encoding=UTF-8", "-Dsun.jnu.encoding=UTF-8", "-jar", "app.war"]
