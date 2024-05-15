# We choose exact tag (not 'latest'), to be sure that new version wont break creating image
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set environment variables
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=P@ssw0rd?

# Create app directory
WORKDIR /usr/src/app

# Copy the setup script and database backup
COPY setup.sql /usr/src/app
COPY CONSULTORIO2.bak /usr/src/app
COPY restore-db.sh /usr/src/app

# Expose port 1433 in case accesing from other container
EXPOSE 1433

# Run Microsoft SQl Server and initialization script (at the same time)
# Note: If you want to start MsSQL only (without initialization script) you can comment bellow line out, CMD entry from base image will be taken
CMD /bin/bash ./entrypoint.sh