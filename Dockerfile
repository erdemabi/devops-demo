# 1. Aşama: Derleme (Build)
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Proje dosyasını kopyala ve paketleri geri yükle
COPY *.csproj ./
RUN dotnet restore

# Tüm dosyaları kopyala ve projeyi yayınla
COPY . .
RUN dotnet publish -c Release -o /app/publish

# 2. Aşama: Çalıştırma (Run)
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app/publish .

# Hugging Face için 7860 portu zorunludur
ENV ASPNETCORE_URLS=http://+:7860
EXPOSE 7860

# Buradaki 'ProjeAdin.dll' kısmını kendi projenin adıyla değiştir!
ENTRYPOINT ["dotnet", "ProjeAdin.dll"]
