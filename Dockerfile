FROM stirlingtools/stirling-pdf:latest

# Working directory
WORKDIR /usr/local/tomcat/webapps/ROOT

# Custom CSS को add करें
COPY custom-styles.css ./css/custom-styles.css

# Logo और Favicon
COPY favicon.ico ./
COPY logo.png ./assets/ 2>/dev/null || true

# सभी HTML files में changes करें
RUN find /usr/local/tomcat/webapps/ROOT -name "*.html" -type f | while read file; do \
    sed -i 's/Stirling PDF/MeraPDF/g' "$file" && \
    sed -i 's/Stirling/MeraPDF/g' "$file" && \
    sed -i 's/<title>.*<\/title>/<title>MeraPDF - Professional PDF Tools<\/title>/g' "$file"; \
done

# Custom CSS को HTML के head में inject करें
RUN find /usr/local/tomcat/webapps/ROOT -name "index.html" | while read file; do \
    sed -i '/<\/head>/i\    <link rel="stylesheet" href="/css/custom-styles.css">' "$file"; \
done

# Favicon को link करें
RUN find /usr/local/tomcat/webapps/ROOT -name "index.html" | while read file; do \
    sed -i '/<\/head>/i\    <link rel="icon" type="image/x-icon" href="/favicon.ico">' "$file"; \
done

EXPOSE 8080
CMD ["catalina.sh", "run"]
