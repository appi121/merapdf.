FROM frooodle/s-pdf:latest

# Custom Favicon और Logo को Copy करें
COPY favicon.ico /usr/local/tomcat/webapps/ROOT/favicon.ico
COPY logo.png /usr/local/tomcat/webapps/ROOT/logo.png

# सभी HTML files में Title Change करें
RUN find /usr/local/tomcat/webapps/ROOT -name "*.html" -type f 2>/dev/null | xargs sed -i 's/Stirling PDF/Mera PDF/g' 2>/dev/null || true

# Assets Folder बनाएं (Logo/Favicon के लिए)
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/assets

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]