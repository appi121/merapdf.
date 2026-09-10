FROM stirlingtools/stirling-pdf:latest

# === ENVIRONMENT VARIABLES (नाम और भाषा) ===
ENV UI_APPNAME="Mera PDF"
ENV UI_APPNAVBARNAME="Mera PDF"
ENV UI_HOMEDESCRIPTION="मुफ्त हिंदी PDF टूल्स - Mera PDF"
ENV SYSTEM_DEFAULTLOCALE="hi-IN"

# === CUSTOM FILES FOLDER बनाएं ===
RUN mkdir -p /customFiles/static

# === CUSTOM CSS COPY करें ===
COPY custom-styles.css /customFiles/static/custom.css

# === CUSTOM FILES ENABLE करें ===
ENV UI_CUSTOM_FILES_ENABLED="true"

EXPOSE 8080
