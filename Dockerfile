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
FROM stirlingtools/stirling-pdf:latest

# सभी "Stirling" को "MeraPDF" से replace करें
RUN find / -name "*.html" -o -name "*.js" -o -name "*.json" | \
    xargs grep -l "Stirling" 2>/dev/null | \
    xargs sed -i 's/Stirling/MeraPDF/g' 2>/dev/null || true

# Title को change करें
RUN find / -name "*.html" -type f 2>/dev/null | \
    xargs sed -i 's/<title>.*<\/title>/<title>MeraPDF - PDF Tools<\/title>/g' 2>/dev/null || true

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
FROM stirlingtools/stirling-pdf:latest

# Custom styles को add करें
COPY custom-styles.css /opt/stirling-pdf/public/css/custom-styles.css

# सभी Stirling references को MeraPDF से replace करें
RUN find /opt/stirling-pdf -type f \( -name "*.html" -o -name "*.js" -o -name "*.json" \) -exec sed -i \
  -e 's/Stirling PDF/MeraPDF/g' \
  -e 's/Stirling/MeraPDF/g' \
  -e 's/stirling/merapdf/gi' {} \; 2>/dev/null || true

# Title को set करें
RUN find /opt/stirling-pdf -name "*.html" -exec sed -i \
  's/<title>.*<\/title>/<title>MeraPDF - Professional PDF Tools<\/title>/g' {} \; 2>/dev/null || true

# Custom CSS को HTML में add करें
RUN find /opt/stirling-pdf -name "index.html" -exec sed -i \
  '/<\/head>/i\    <link rel="stylesheet" href="/css/custom-styles.css">' {} \; 2>/dev/null || true

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
