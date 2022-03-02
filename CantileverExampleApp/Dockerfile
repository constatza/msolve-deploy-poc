# Base image to be published
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
LABEL author=”MGroup”
WORKDIR /CantileverExampleApp

# Build .NET app
FROM mcr.microsoft.com/dotnet/core/sdk AS build
WORKDIR /CantileverExampleApp
# paths are always relative to the root of the repository
COPY CantileverExampleApp/CantileverExampleDocker.Docker.csproj .
RUN dotnet restore
COPY CantileverExampleApp .
RUN dotnet build -c Release

# Publish .NET app
FROM build AS publish
RUN dotnet publish -c Release -o /publish

# Final image with entrypoint
FROM base AS final
WORKDIR /CantileverExampleApp
COPY --from=publish /publish .
# ENTRYPOINT ["dotnet", "CantileverExampleDocker.Docker.dll"]
