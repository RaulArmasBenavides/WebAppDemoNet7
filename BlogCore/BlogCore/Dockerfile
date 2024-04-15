#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.


# We choose exact tag (not 'latest'), to be sure that new version wont break creating image
FROM mcr.microsoft.com/mssql/server:2022-latest
WORKDIR /usr/src/app # Create app directory
COPY . /usr/src/app # Copy initialization scripts
EXPOSE 1433 # Expose port 1433 in case accesing from other container
# Run Microsoft SQl Server and initialization script (at the same time)
# Note: If you want to start MsSQL only (without initialization script) you can comment bellow line out, CMD entry from base image will be taken
CMD /bin/bash ./entrypoint.sh


FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["BlogCore/BlogCore.csproj", "BlogCore/"]
COPY ["BlogCore.AccesoDatos/BlogCore.AccesoDatos.csproj", "BlogCore.AccesoDatos/"]
COPY ["BlogCore.Models/BlogCore.Models.csproj", "BlogCore.Models/"]
COPY ["BlogCore.Utilidades/BlogCore.Utilidades.csproj", "BlogCore.Utilidades/"]
RUN dotnet restore "./BlogCore/./BlogCore.csproj"
COPY . .
WORKDIR "/src/BlogCore"
RUN dotnet build "./BlogCore.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./BlogCore.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BlogCore.dll"]