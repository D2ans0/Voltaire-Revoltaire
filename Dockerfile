### Build stage ###
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as voltaire_build

WORKDIR /build/

ENV USER=D2ans0
ENV REPO=Voltaire-Revoltaire
ENV BRANCH=master
ENV URL=https://github.com/$USER/$REPO.git


ADD https://api.github.com/repos/$USER/$REPO/git/refs/heads/$BRANCH /tmp/version.json
RUN git clone -b ${BRANCH} ${URL} ./
RUN dotnet publish -c Release -o voltaire-bin

### Package stage ###
FROM mcr.microsoft.com/dotnet/runtime:latest

WORKDIR /app/

COPY --from=voltaire_build /build/voltaire-bin/ /app/

# Set config permissions and start app
ENTRYPOINT dotnet Voltaire.dll
