FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /src

COPY SampleWebApiAspNetCore/*.csproj SampleWebApiAspNetCore/
RUN dotnet restore SampleWebApiAspNetCore/*.csproj

COPY . .
WORKDIR /src/SampleWebApiAspNetCore
RUN dotnet publish -c Release -o /out --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

COPY --from=build-env /out .

EXPOSE 5001
ENV ASPNETCORE_URLS=http://+:5001
ENV ASPNETCORE_ENVIRONMENT=Development

ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]



