### Build stage ###
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as voltaire_build

WORKDIR /build/

ENV REPO="https://github.com/D2ans0/Voltaire-Revoltaire.git"

RUN git clone ${REPO} ./
RUN dotnet publish -c Release -o voltaire-bin


### Package stage ###
FROM mcr.microsoft.com/dotnet/runtime:latest

WORKDIR /app/

COPY --from=voltaire_build /build/voltaire-bin/ /app/

# Set config permissions and start app
ENTRYPOINT dotnet Voltaire.dll
