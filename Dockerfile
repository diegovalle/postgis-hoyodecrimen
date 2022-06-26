FROM postgis/postgis:14-3.2
ENV POSTGRES_USER=deploy
ENV POSTGRES_DB=apihoyodecrimen
COPY init.sh /docker-entrypoint-initdb.d/
# RUN chown 999 -R /var/lib/postgresql/data
USER 999
# ENV POSTGRES_PASSWORD=
# ENV BACKUP_USER_PASSWORD=
# ENV HOYODECRIMEN_USER_PASSWORD=
# TCP 5432
# VOLUME-MOUNT VOLUME-MOUNT pgdata-ko89b2 /var/lib/postgresql/data
# CHANGE_OWNER CHOWN /pgdata-ko89b2 999
