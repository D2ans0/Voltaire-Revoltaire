### Build stage ###
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as voltaire_build

WORKDIR /build/

ENV REPO="https://github.com/D2ans0/Voltaire-Revoltaire.git"
ARG BRANCH="master"
ADD https://api.github.com/repos/D2ans0/Voltaire-Revoltaire/commits?sha=${BRANCH}&per_page=1 /tmp/version.json
RUN git clone -b ${BRANCH} ${REPO} ./
RUN dotnet publish -c Release -o voltaire-bin

### Package stage ###
FROM mcr.microsoft.com/dotnet/runtime:latest

WORKDIR /app/

COPY --from=voltaire_build /build/voltaire-bin/ /app/

# Set config permissions and start app
ENTRYPOINT dotnet Voltaire.dll
