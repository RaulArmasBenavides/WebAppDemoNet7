#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

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