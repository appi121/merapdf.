FROM stirlingtools/stirling-pdf:latest

WORKDIR /usr/local/tomcat/webapps/ROOT

# Custom files को सही जगह पर copy करो
COPY favicon.ico ./modern-logo/
COPY logo.png ./modern-logo/
COPY custom-styles.css ./assets/

# Title को change करो (HTML में)
RUN sed -i 's/<title>Stirling PDF<\/title>/<title>MeraPDF - Professional PDF Tools<\/title>/g' ./index.html

# Meta tags में भी "Stirling" को "MeraPDF" से replace करो
RUN sed -i 's/Stirling PDF/MeraPDF/g' ./index.html && \
    sed -i "s/The Free Adobe Acrobat alternative/Professional PDF Processing Tool/g" ./index.html

# Custom CSS को HTML में add करो (head के अंदर)
RUN sed -i '/<link rel="stylesheet" crossorigin href="\.\/assets\/index/a \ <link rel="stylesheet" href="./assets/custom-styles.css">' ./index.html

# Favicon path को ठीक करो
RUN sed -i 's|href="modern-logo/favicon.ico"|href="/modern-logo/favicon.ico"|g' ./index.html

EXPOSE 8080
CMD ["catalina.sh", "run"]
