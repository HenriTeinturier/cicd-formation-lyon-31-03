# On part de l’image officielle PostgreSQL
FROM postgres:17

# Variables d’environnement pour créer l’utilisateur,
# mot de passe et base de données
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=demo

# On copie le script SQL dans le dossier reconnu par PostgreSQL
COPY ./postgres-init-image/init.sql /docker-entrypoint-initdb.d/