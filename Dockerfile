FROM tomcat:10.1-jdk25-temurin-noble AS build

WORKDIR /app

COPY src/main/java ./src/main/java
COPY src/main/webapp ./src/main/webapp

RUN mkdir -p src/main/webapp/WEB-INF/classes && \
    javac -cp "/usr/local/tomcat/lib/*:src/main/webapp/WEB-INF/lib/*" \
    -d src/main/webapp/WEB-INF/classes \
    $(find src/main/java -name "*.java") && \
    rm -rf src/main/java


FROM tomcat:10.1-jre25-temurin-noble

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

ENV PORT=10000

CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT}\\\"/\" /usr/local/tomcat/conf/server.xml && exec catalina.sh run"]