FROM maven:3.6-jdk-11 AS maven
WORKDIR /app
RUN git clone https://github.com/JothamB/usersWeb.git
WORKDIR /app/usersWeb
RUN mvn install

FROM tomcat:9
COPY --from=maven /app/usersWeb/target/usersWeb.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh", "run"]
