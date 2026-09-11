FROM stirlingtools/stirling-pdf:latest

# Working directory
WORKDIR /usr/local/tomcat/webapps/ROOT

# Custom CSS को add करें
COPY custom-styles.css ./css/custom-styles.css

# Logo और Favicon
COPY favicon.ico ./
COPY logo.png ./assets/ 2>/dev/null || true

# सभी HTML files में "Stirling" को "MeraPDF" से replace करें
RUN find /usr/local/tomcat/webapps/ROOT -type f \( -name "*.html" -o -name "*.js" \) \
 -exec sed -i 's/Stirling PDF/MeraPDF/g; s/Stirling/MeraPDF/g; s/STIRLING/MERAPDF/g' {} \;

# Title को set करें
RUN find /usr/local/tomcat/webapps/ROOT -name "*.html" \
 -exec sed -i 's/<title>.*<\/title>/<title>MeraPDF - Professional PDF Tools<\/title>/g' {} \;

# Favicon को link करें
RUN find /usr/local/tomcat/webapps/ROOT -name "index.html" \
 -exec sed -i '/<\/head>/i\ <link rel="icon" type="image\/x-icon" href="\/favicon.ico">' {} \;

# Custom CSS को load करें
RUN find /usr/local/tomcat/webapps/ROOT -name "index.html" \
 -exec sed -i '/<\/head>/i\ <link rel="stylesheet" href="\/css\/custom-styles.css">' {} \;

EXPOSE 8080
CMD ["catalina.sh", "run"]
