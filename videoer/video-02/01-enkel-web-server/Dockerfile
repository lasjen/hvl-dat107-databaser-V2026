# Bruk et lettvekts Nginx base image
FROM nginx:alpine

# Eksponer port 80 (standard HTTP-port)
EXPOSE 80

# Legg til en VOLUME instruksjon for å definere mount point
VOLUME ["/usr/share/nginx/html"]

# Kjør Nginx i forgrunnen for at containeren skal forbli aktiv
CMD ["nginx", "-g", "daemon off;"]
